import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/fireabse/firebase_actions.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/constants/constants.dart';

import '../../../core/models/content/content_model/content_model.dart';
import '../../../core/models/subscriber/subscriber_model.dart';
import '../../../core/provider/user_provider.dart';

class AddToWatchlistMobileButton extends StatefulWidget {
  final Datum content;
  const AddToWatchlistMobileButton({super.key, required this.content});

  @override
  State<AddToWatchlistMobileButton> createState() =>
      _AddToWatchlistMobileButtonState();
}

class _AddToWatchlistMobileButtonState
    extends State<AddToWatchlistMobileButton> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    isActive = widget.content.inwatchlist;
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
          SubscriberModel? model =
              Provider.of<UserProvider>(context, listen: false).subscriberModel;
          if (model != null) {
            FirebaseActions().firebaseAddOrRemoveFromWatchList(
                widget.content, !widget.content.inwatchlist);

            widget.content.inwatchlist
                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        widget.content.objecttype == ContentModel.series
                            ? Constants.courseRemovedFromWatchList
                            : Constants.videoRemovedFromWatchList)))
                : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        widget.content.objecttype == ContentModel.series
                            ? Constants.courseAddedTOWatchList
                            : Constants.videoAddedTOWatchList)));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Please login!")));
          }
        },
        child: SizedBox(
          width: 100,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(Constants.insetPadding),
              child: Column(
                children: [
                  Icon(
                    (widget.content.inwatchlist)
                        ? Icons.remove_circle
                        : Icons.add_circle,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    height: Constants.semanticsMarginExSmall,
                  ),
                  Text(
                    "Watchlist",
                    style: TextStyle(color: AppColors.primaryColor),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void didChangeDependencies() {
    //fetchContentFromFirebase();
    super.didChangeDependencies();
  }
}
