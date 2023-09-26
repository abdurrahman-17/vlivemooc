import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';
import 'package:vlivemooc/core/network/network_handler.dart';
import 'package:vlivemooc/ui/animations/loading_animation.dart';
import 'package:vlivemooc/ui/screens/courses/mobile_course_detail.dart';
import 'package:vlivemooc/ui/screens/courses/web_course_detail.dart';
import '../../../core/provider/firebase_provider.dart';
import '../../responsive/responsive.dart';
import '../../../core/models/coaches/coach_model/datum.dart' as coachclass;

class CourseDetailScreen extends StatefulWidget {
  final Datum? content;
  final String contentid;
  const CourseDetailScreen(
      {super.key, required this.content, required this.contentid});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  Datum? content;
  coachclass.Datum? coach;
  String price = "";
  String currency = "";
  @override
  void initState() {
    super.initState();
    content = widget.content;
    if (content == null) {
      getContentDetail((content) {
        fetchContentFromFirebase();
        getCoach(content);
        getPrice(content);
      });
    } else {
      getCoach(content!);
      getPrice(content!);
    }
  }

  @override
  void didChangeDependencies() {
    fetchContentFromFirebase();
    super.didChangeDependencies();
  }

  onFetchContinueWatching(FireDatum fireContent){
        setState(() {
          content!.inwatchlist=fireContent.inwatchlist??false;
        });
      }

  getPrice(Datum content) async {
    // try {
    //   ChaptersModel chaptersModel = await NetworkHandler.getChapters(
    //       seriesid: widget.content!.objectid!, seasonnum: "1");
    //   Datum contentObj = Datum.fromJson(chaptersModel.data![0].toJson());

    //   String availabilityID =
    //       contentObj.contentdetails![0].availabilityset![0].toString();
    //   var data = await NetworkHandler.getPriceClass(availabilityID);

    //   String currency_ = data['priceclassdetail'][0]['currency'].toString();
    //   String price_ = data['priceclassdetail'][0]['price'].toString();
    //   setState(() {
    //     currency = currency_;
    //     price = price_;
    //   });
    // } catch (err) {
    //   //do nothing
    // }
  }

  getCoach(Datum content) async {
    if (content.partnerid == null || content.partnerid.toString().isEmpty) {
      return;
    }
    coachclass.Datum? datum = await NetworkHandler.getCoach(content.partnerid!);
    setState(() {
      coach = datum;
    });
  }

  getContentDetail(onLoaded) async {
    Datum datum = await NetworkHandler.getContentDetail(widget.contentid);
    setState(() {
      content = datum;
    });
    onLoaded(datum);
  }
  FireDatum? fireDatum;

  @override
  Widget build(BuildContext context) {
    if (content == null) {
      return const Scaffold(
        body: Center(
          child: LoadingAnimation(),
        ),
      );
    }
    return Responsive(
        mobileView: MobileCourseDetail(
          coach: coach,
          content: content!,
          price: price,
          currency: currency,
        ),
        desktopView: WebCourseDetail(
          coach: coach,
          content: content!,
          price: price,
          currency: currency,
        ));
  }

  void fetchContentFromFirebase() {
        if(content!=null){
          FirebaseProvider model = Provider.of<FirebaseProvider>(context);
          model.fetchContentFromFirebase(content!, context, onFetchContinueWatching);
        }

  }
}
