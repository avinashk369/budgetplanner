class MathUtils {
  static int getPercentage(double first, double second) {
    int percent = 0;
    percent = ((second * 100) / first).round();
    return percent;
  }
}
