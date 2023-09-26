import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/fireabse/firebase_actions.dart';
import '../../../core/fireabse/firebase_constants.dart';
import '../../../core/models/subscriber/subscriber_model.dart';
import '../../../core/provider/provider_constants.dart';
import '../../../core/provider/user_provider.dart';

class DislikeButton extends StatefulWidget {
  final Datum content;
  final bool isMobile;
  const DislikeButton(
      {super.key, required this.content, required this.isMobile});

  @override
  State<DislikeButton> createState() => _DislikeButtonState();
}

class _DislikeButtonState extends State<DislikeButton> {
  bool isActive = false;

  bool isDisLiked=false;
  SubscriberModel? model;

  @override
  void didChangeDependencies() {
    fetchContentFromFirebase();
    super.didChangeDependencies();

  }

  void fetchContentFromFirebase() async {
    if(!ProviderConstants.isLoggedIn)
    {
      return;
    }
    //Fetch subscriber and then get the fire contents like&dislikestatus
    model = Provider.of<UserProvider>(context).subscriberModel;
    if (model != null) {
      firebaseActions.fetchLikeDislikeStatusForAContent(
          likeDisLikeStatus: (String status){setState(() {
            setState(() {
              isDisLiked=(status==FirebaseConstants.dislike);
              isActive= isDisLiked;

            });
          });},
          subscriberId: model!.subscriberId,
          objectid: widget.content.objectid);
    }

  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          isActive = value;
        });
      },
      onTap: () {

        if(model!=null)
        {
          FirebaseActions().updateLikeDislikeFirebase(widget.content, isDisLiked?FirebaseConstants.actionNone:FirebaseConstants.dislike);
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please login!")));
        }
      },
      child: widget.isMobile
          ? SizedBox(
              width: 100,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(Constants.insetPadding),
                  child: Column(
                    children: [
                      Icon(
                        (isActive||isDisLiked)
                            ? Icons.thumb_down_alt
                            : Icons.thumb_down_alt_outlined,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        height: Constants.semanticsMarginExSmall,
                      ),
                      Text(
                        "Dislike",
                        style: TextStyle(color: AppColors.primaryColor),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  (isActive||isDisLiked)
                      ? Icons.thumb_down_alt
                      : Icons.thumb_down_alt_outlined,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  width: Constants.semanticsMarginExSmall,
                ),
                Text(
                  "Dislike",
                  style: TextStyle(color: AppColors.primaryColor),
                )
              ],
            ),
    );
  }
}
