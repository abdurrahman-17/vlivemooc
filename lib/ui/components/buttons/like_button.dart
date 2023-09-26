import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/fireabse/firebase_constants.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/subscriber/subscriber_model.dart';
import '../../../core/provider/provider_constants.dart';
import '../../../core/provider/user_provider.dart';

class LikeButton extends StatefulWidget {
  final Datum content;
  final bool isMobile;
  final bool isCarousal;

  const LikeButton({super.key, required this.content, required this.isMobile, this.isCarousal = false});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isActive = false;
  bool isLiked = false;
  SubscriberModel? model;
  @override
  void initState() {
    super.initState();

  }

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
              isLiked=(status==FirebaseConstants.like);
              isActive= isLiked;
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
          FirebaseActions().updateLikeDislikeFirebase(widget.content, isLiked?FirebaseConstants.actionNone:FirebaseConstants.like);
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please login!")));
        }
      },
      child:  widget.isMobile
          ? SizedBox(
        width: 100,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(Constants.insetPadding),
            child: Column(
              children: [
                Icon(
                  (isLiked|| isActive)
                      ? Icons.thumb_up_alt
                      : Icons.thumb_up_alt_outlined,
                  color: widget.isCarousal ? Colors.white : AppColors.primaryColor,
                ),
                if(!widget.isCarousal)const SizedBox(
                  height: Constants.semanticsMarginExSmall,
                ),
                if(!widget.isCarousal)Text(
                  "Like",
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
            (isLiked|| isActive) ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
            color: widget.isCarousal ? Colors.white : AppColors.primaryColor,
          ),
          if(!widget.isCarousal)const SizedBox(
            width: Constants.semanticsMarginExSmall,
          ),
          if(!widget.isCarousal)Text(
            "Like",
            style: TextStyle(color: AppColors.primaryColor),
          )
        ],
      ),
    );
  }
}
