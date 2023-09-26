import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/models/subscriber/subscriber_model.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/components/buttons/boxed_text_field.dart';
import 'package:http_parser/http_parser.dart';
import 'package:vlivemooc/ui/components/buttons/circular_loading_button.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class BasicInformation extends StatefulWidget {
  final bool isMobile;
  const BasicInformation({super.key, required this.isMobile});

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  bool canEdit = false;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  String profileImageUrl = "";
  bool imageUploading = false;
  bool isFormLoading = false;
  String formError = "";

  Future<dynamic> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.readAsBytes();
    }
    return null;
  }

  updateProfile(callback) async {
    if (nameController.text.isEmpty) {
      setState(() {
        formError = "Name is required";
      });
      return;
    }
    setState(() {
      isFormLoading = true;
    });
    await NetworkHandler.saveProfile(payload: {
      "subscribername": nameController.text,
      "email": emailController.text
    });
    await NetworkHandler.getSubscriber();
    callback();
  }

  uploadImage(callback) async {
    var image = await pickImage();
    if (image != null) {
      FormData formData = FormData.fromMap({
        "filename": MultipartFile.fromBytes(
          image,
          contentType: MediaType('image', 'jpeg'),
          filename: "filename",
        ),
      });
      try {
        var data = await NetworkHandler.uploadProfilePicture(formData);
        await NetworkHandler.saveProfile(payload: {"picture": data['success']});
        SubscriberModel model = await NetworkHandler.getSubscriber();
        setState(() {
          profileImageUrl = model.picture!;
        });
        callback(true, "Profile photo updated successfully");
      } catch (error) {
        callback(false, "Upload failed, image size too large");
      }
    } else {
      callback(false, "No file selected");
    }
  }

  @override
  void initState() {
    super.initState();
    SubscriberModel? model =
        Provider.of<UserProvider>(context, listen: false).subscriberModel;
    if (model != null) {
      nameController = TextEditingController(text: model.profileName);
      phoneController = TextEditingController(text: model.mobileNo);
      emailController = TextEditingController(text: model.email);
      profileImageUrl = model.picture ?? "";
    } else {
      nameController = TextEditingController();
      phoneController = TextEditingController();
      phoneController = TextEditingController();
    }
    nameController.addListener(() {
      setState(() {
        formError = "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        !canEdit
            ? Positioned(
                top: 0,
                right: 0,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      canEdit = true;
                    });
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 12.0,
                      backgroundColor: AppColors.primaryColor,
                      textStyle: const TextStyle(color: Colors.white)),
                  label: const Text("Edit"),
                ))
            : Container(),
        Positioned(
            top: 25,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.isMobile
                      ? Container()
                      : Stack(children: [
                          imageUploading
                              ? const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 40,
                                  child: LoadingAnimation(),
                                )
                              : profileImageUrl.isEmpty
                                  ? CircleAvatar(
                                      backgroundColor: AppColors.accentColor,
                                      foregroundColor: AppColors.primaryColor,
                                      radius: 40,
                                      child: const Icon(
                                        Icons.person,
                                        size: 30,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          NetworkImage(profileImageUrl),
                                      radius: 40,
                                    ),
                          canEdit
                              ? Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Card(
                                    elevation: 4,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          imageUploading = true;
                                        });
                                        uploadImage((hasUploaded, reason) {
                                          setState(() {
                                            imageUploading = false;
                                          });
                                          if (hasUploaded) {
                                            Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .updateSubscriber();
                                          }
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(reason)));
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ))
                              : Container()
                        ]),
                  widget.isMobile
                      ? Container()
                      : const SizedBox(
                          width: Constants.semanticMarginDefault,
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      !widget.isMobile
                          ? Container()
                          : Stack(children: [
                              imageUploading
                                  ? const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 40,
                                      child: LoadingAnimation(),
                                    )
                                  : profileImageUrl.isEmpty
                                      ? CircleAvatar(
                                          backgroundColor:
                                              AppColors.accentColor,
                                          foregroundColor:
                                              AppColors.primaryColor,
                                          radius: 40,
                                          child: const Icon(
                                            Icons.person,
                                            size: 30,
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage:
                                              NetworkImage(profileImageUrl),
                                          radius: 40,
                                        ),
                              canEdit
                                  ? Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Card(
                                        elevation: 4,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              imageUploading = true;
                                            });
                                            uploadImage((hasUploaded, reason) {
                                              setState(() {
                                                imageUploading = false;
                                              });
                                              if (hasUploaded) {
                                                Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .updateSubscriber();
                                              }
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(reason)));
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ))
                                  : Container()
                            ]),
                      !widget.isMobile
                          ? Container()
                          : const SizedBox(
                              height: Constants.semanticMarginDefault,
                            ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: BoxedTextField(
                          errorText: formError,
                          enabled: canEdit,
                          controller: nameController,
                          titleText: "Name",
                          icon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(
                        height: Constants.semanticsMarginExSmall,
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: BoxedTextField(
                          enabled: false,
                          controller: phoneController,
                          titleText: "Phone",
                          icon: const Icon(Icons.phone),
                        ),
                      ),
                      const SizedBox(
                        height: Constants.semanticsMarginExSmall,
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: BoxedTextField(
                          enabled: false,
                          controller: emailController,
                          titleText: "Email",
                          icon: const Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(
                        height: Constants.semanticMarginDefault,
                      ),
                      canEdit
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: Constants.buttonHeight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        canEdit = false;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 4.0,
                                      backgroundColor: AppColors.accentColor,
                                    ),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: Constants.semanticMarginDefault,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: CircularLoadingElevatedButton(
                                      buttonText: "Save",
                                      isLoading: isFormLoading,
                                      onTap: () {
                                        updateProfile(() {
                                          setState(() {
                                            canEdit = false;
                                            isFormLoading = false;
                                          });
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .updateSubscriber();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Profile was updated successfully")));
                                        });
                                      }),
                                )
                              ],
                            )
                          : Container()
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
