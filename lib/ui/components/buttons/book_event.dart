import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/events/events_service.dart';
import 'package:vlivemooc/core/models/coaches/events_model/response.dart';
import 'package:vlivemooc/core/provider/user_provider.dart';
import 'package:vlivemooc/ui/constants/colors.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

import 'circular_loading_button.dart';

class BookEvent extends StatefulWidget {
  final Response event;
  const BookEvent({super.key, required this.event});

  @override
  State<BookEvent> createState() => _BookEventState();
}

class _BookEventState extends State<BookEvent> {
  bool isLoading = false;

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Confirm event booking'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to book this event?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style:
                  TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style:
                  TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
              child: const Text('Book Event'),
              onPressed: () {
                Navigator.of(context).pop();
                onBookEvent();
              },
            ),
          ],
        );
      },
    );
  }

  onBookEvent() async {
    bool isLoggedin =
        Provider.of<UserProvider>(context, listen: false).isLoggedIn;
    if (!isLoggedin) {
      Provider.of<UserProvider>(context, listen: false)
          .setRedirectLocation(AppRouter.events);
      context.go(AppRouter.signup);
      return;
    }
    setState(() {
      isLoading = true;
    });
    EventsService eventsService = EventsService();
    try {
      eventsService.bookEvent(
          event: widget.event,
          onError: (error) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text("Session not available, please try again later.")));
          },
          onCompletedCallback: (String response, bool hasSucceeded) {
            setState(() {
              isLoading = false;
            });
            if (!hasSucceeded) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(response)));
              return;
            }
            if (response.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Event has been booked successfully")));
              context.go(AppRouter.home);
            } else {
              eventsService.onCheckoutUrl(context, response);
            }
          });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong. Please try again later")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircularLoadingElevatedButton(
      height: 30,
      onTap: () {
        _showAlertDialog();
      },
      isLoading: isLoading,
      buttonText: "Book",
    );
  }
}
