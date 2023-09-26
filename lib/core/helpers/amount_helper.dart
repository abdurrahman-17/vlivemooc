import 'package:intl/intl.dart';

AmountHelper amountHelper = AmountHelper();

class AmountHelper {
  String formatAmountInDouble(String amount) {
    var formatter = NumberFormat('#,##,000.00');
    return formatter.format(double.parse(amount));
  }

}