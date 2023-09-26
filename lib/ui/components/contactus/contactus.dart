import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlivemooc/core/helpers/app_screen_dimen.dart';
import 'package:vlivemooc/ui/components/appbar/top_bar.dart';
import 'package:vlivemooc/ui/components/footer/web_footer.dart';
import 'package:vlivemooc/ui/constants/colors.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController helpTextController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(
        logoPath: "assets/images/logo_white.png",
        backgroundColor: AppColors.primaryColor,
        renderNav: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  sizedBoxHeight30(context),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 50.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Contact EnrichTV",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Inter-Bold",
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "The best way to get in touch with us fill out the form with your inquiry or mail us at info@enrichtv.com.",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Inter-Medium",
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "you can also call our support desk on +91 8828823641 (07:00 AM to 10:00 PM)",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Inter-Medium",
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          color: const Color(0xfff1ab61),
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 25, bottom: 60),
                          child: Form(
                            key: formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Your Name:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Inter-Medium",
                                      color: Colors.black),
                                ),
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Name required";
                                    }
                                    return null;
                                  },
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                sizedBoxHeight20(context),
                                const Text(
                                  "Your email:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Inter-Medium",
                                      color: Colors.black),
                                ),
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Email required";
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                sizedBoxHeight20(context),
                                const Text(
                                  "How can we help you:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Inter-Medium",
                                      color: Colors.black),
                                ),
                                TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Notes required";
                                    }
                                    return null;
                                  },
                                  controller: helpTextController,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                sizedBoxHeight20(context),
                                TextButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      openMail();
                                    }
                                  },
                                  child: Container(
                                    color: AppColors.buttonTextBlue,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            const WebFooter()
          ],
        ),
      ),
    );
  }

  openMail() async {
    String email = Uri.encodeComponent("info@enrichtv.com");
    String subject = Uri.encodeComponent("EnrichTv Contact Us");
    String body = Uri.encodeComponent(
        "${"Name: ${nameController.text}"} \n ${"EmailID: ${emailController.text}"} \n ${"Notes: ${helpTextController.text}"}");
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }
}
