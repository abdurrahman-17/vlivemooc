import 'package:intl/intl.dart';

class TimeCalculator {
  static formatTimeInContentDuration({required int? timeInSecond}) {
    if (timeInSecond == null) {
      return "00:00";
    }
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }

  int currentTime() {
    DateTime now = DateTime.now();
    return now.millisecondsSinceEpoch ~/ 1000;
  }

  formatTimetoMinsFromSec({required int? timeInSecond}) {
    if (timeInSecond == null) {
      return "00";
    }
    // int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    return minute;
  }

  formatTimetoMinsSecsFromSec({required int? timeInSecond}) {
    if (timeInSecond == null) {
      return "00:00";
    }
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }


  String formatDateMMMddYYYY(String dateString) {
    final dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString);
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }
}
