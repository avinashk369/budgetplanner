class MathUtils {
  static int getPercentage(double first, double second) {
    return (first > 0) ? ((second * 100) ~/ first).toInt() : 0;
  }

  static double gridSeparator(double totalAMount) {
    if (totalAMount < 1000) totalAMount = 1000;
    double val = ((totalAMount / 1000).round() * 1000).roundToDouble();
    // String s = totalAMount.toInt().toString();
    // String sf = s.substring(0, 1);
    // String sT = s.substring(1);
    // var regex = new RegExp(r'[0-9]');
    // double finalAmount = double.parse(
    //     (int.parse(sf) + 1).toString() + sT.replaceAll(regex, '0'));
    // print("$finalAmount rounded value $val");

    return val;
  }
}
