import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vlivemooc/core/events/events_service.dart';
import 'package:vlivemooc/core/helpers/book_state.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/core/provider/provider_constants.dart';
import 'package:vlivemooc/ui/routes/routes.dart';

import '../../../core/models/coaches/coach_model/datum.dart';
import '../coaches/calendly_view.dart';
import 'circular_loading_button.dart';

class BookSession extends StatefulWidget {
  final Datum coach;
  const BookSession({super.key, required this.coach});

  @override
  State<BookSession> createState() => _BookSessionState();
}

class _BookSessionState extends State<BookSession> {
  late BookState bookState;
  var eventDetails = {};
  @override
  void initState() {
    super.initState();
    bookState = BookState(buttonState: "", isLoading: true);
    setButtonState();
  }

  setButtonState() async {
    if (!ProviderConstants.isLoggedIn) {
      setState(() {
        bookState = BookState(buttonState: BookState.login, isLoading: false);
      });
      return;
    }
    try {
      var details = await NetworkHandler.getInstructorEventDetails(
          widget.coach.partnerid);
      setState(() {
        bookState = BookState(buttonState: BookState.book, isLoading: false);
        eventDetails = details;
      });
    } catch (instructorNotAvailable) {
      setState(() {
        bookState = BookState(
            buttonState: BookState.unavailable,
            isLoading: false,
            isDisabled: true);
      });
    }
  }

  onBookSessionClick() async {
    if (bookState.buttonState == BookState.login) {
      context.go(AppRouter.signup);
      return;
    }
    String calendlyUrl = "";
    try {
      calendlyUrl = eventDetails['onetimeURL']['resource']['booking_url'];
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Booking not available, please contact support")));
      return;
    }
    openCalendly(
        calendlyUrl: calendlyUrl,
        onCheckoutGenerated: (checkoutUrl) {
          EventsService().onCheckoutUrl(context, checkoutUrl);
        });
  }

  openCalendly({required String calendlyUrl, required onCheckoutGenerated}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((ctx) => CalendlyView(
                url: calendlyUrl,
                onCalendlyResponse: (response) async {
                  setState(() {
                    bookState = BookState(buttonState: "", isLoading: true);
                  });
                  String instructorId = widget.coach.partnerid!;
                  String inviteeUri = response['invitee']['uri'].toString();

                  String eventdata = inviteeUri.replaceAll(
                      "https://api.calendly.com/scheduled_events/", "");
                  eventdata = eventdata.replaceAll("invitees", "");
                  var objectids = eventdata.split("//");

                  String idevent = eventDetails['idevent'];
                  String amount = eventDetails['amount'];

                  Map<String, String> params = {
                    'eventid': idevent,
                    'hostid': instructorId,
                    'calendlyid': objectids[0],
                    'Scheduleid': objectids[1],
                    'purchaseid': "1hgwtrd",
                    'starttime': "2023-10-17 19",
                    'endtime': "2023-10-17 23",
                  };

                  var data = await NetworkHandler.initializeSession(params);

                  String sessionid = data['success'];
                  var objectData = {
                    'amount': amount,
                    'hostid': instructorId,
                    'eventid': idevent,
                    'sessionid': sessionid
                  };

                  String checkoutUrl =
                      await EventsService().generateCheckoutUrl(objectData);
                  onCheckoutGenerated(checkoutUrl);
                  setState(() {
                    bookState = BookState(
                        buttonState: BookState.book, isLoading: false);
                  });
                }))));
  }

  @override
  Widget build(BuildContext context) {
    return CircularLoadingElevatedButton(
      height: 40,
      onTap: () {
        onBookSessionClick();
      },
      isLoading: bookState.isLoading,
      buttonText: bookState.buttonState,
      disabled: bookState.isDisabled,
    );
  }
}
