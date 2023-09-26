import 'package:flutter/material.dart';
import 'package:vlivemooc/ui/responsive/responsive.dart';

import '../../components/mylearnings/my_learnings_mobile.dart';
import '../../components/mylearnings/my_learnings_web.dart';


class MyLearnings extends StatefulWidget {
 final bool isMobile;
  const MyLearnings( {Key? key,required this.isMobile}) : super(key: key);

  @override
  State<MyLearnings> createState() => _MyLearningsState();
}

class _MyLearningsState extends State<MyLearnings>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.isMobile?3:2, vsync: this);
  }

  List<String> statusData = ["Progress", "Completed"];
  TextEditingController statusController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return const Responsive(mobileView: MyLearningsMobile(), desktopView: MyLearningsWeb());


  }

}


