class MathUtils {
  static int getPercentage(double first, double second) {
    return (first > 0) ? ((second * 100) ~/ first).toInt() : 0;
  }
}
