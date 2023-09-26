import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/models/content/content_model/content_model.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/provider/provider_constants.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/subscriber/subscriber_model.dart';
import '../../../core/provider/user_provider.dart';

class AddToWatclist extends StatefulWidget {
  final Datum content;
  final double size;
  final bool isCarousal;
  const AddToWatclist({super.key, required this.content, this.size = 30, this.isCarousal = false});

  @override
  State<AddToWatclist> createState() => _AddToWatclistState();
}

class _AddToWatclistState extends State<AddToWatclist> {

  onTapped({required callback}) async {
    if (model!=null) {
      firebaseActions.firebaseAddOrRemoveFromWatchList(widget.content,!widget.content.inwatchlist);
      callback(true);
    } else {
      callback(false);
    }
  }

  bool hovered = false;
  SubscriberModel? model;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(ProviderConstants.isLoggedIn)
    {
      model = Provider.of<UserProvider>(context).subscriberModel;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (details) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (details) {
        setState(() {
          hovered = false;
        });
      },
      child: IconButton(
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          onPressed: () {
            onTapped(callback: (isAdded) {
              if (isAdded) {
                widget.content.inwatchlist?
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(widget.content.objecttype==ContentModel.series? Constants.courseRemovedFromWatchList: Constants.videoRemovedFromWatchList)))
                    : ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(widget.content.objecttype==ContentModel.series? Constants.courseAddedTOWatchList: Constants.videoAddedTOWatchList)));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please login!")));
              }
            });
          },
          icon: Icon(
            widget.content.inwatchlist? Icons.remove_circle_outline: Icons.add_circle,
            color:widget.isCarousal ? Colors.white : hovered
                ? AppColors.primaryColor.withOpacity(0.6)
                : AppColors.primaryColor,
            size: widget.size,
          )),
    );
  }
}
