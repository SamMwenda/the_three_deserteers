import 'dart:math';

class MathProblem {
  ///generate simple random expression
  static String generatedProblem() {
    Random number = Random();
    Random symbol = Random();
    List<String> values = [];
    for (int i = 0; i < 15; i++) {
      if (i == 2) {
        int num = symbol.nextInt(9);
        if (num <= 3) {
          values.add("+");
        } else if (num <= 5 && num >= 4) {
          values.add("*");
        } else if (num == 6) {
          values.add("/");
        } else {
          values.add("-");
        }
      } else if (i == 6) {
        int num = symbol.nextInt(9);
        if (num <= 3) {
          values.add("+");
        } else if (num <= 5 && num >= 4) {
          values.add("*");
        } else if (num == 6) {
          values.add("/");
        } else {
          values.add("-");
        }
      } else if (i == 9) {
        int num = symbol.nextInt(9);
        if (num <= 3) {
          values.add("+");
        } else if (num <= 5 && num >= 4) {
          values.add("*");
        } else if (num == 6) {
          values.add("/");
        } else {
          values.add("-");
        }
      } else if (i == 12) {
        int num = symbol.nextInt(9);
        if (num <= 3) {
          values.add("+");
        } else if (num <= 5 && num >= 4) {
          values.add("*");
        } else if (num == 6) {
          values.add("/");
        } else {
          values.add("-");
        }
      } else {
        values.add(number.nextInt(9).toString());
      }
    }
    return values.toString();
  }

  /// list expression to String
  ///{12+23} to 12+23
  static String expression() {
    final expression1 = generatedProblem().replaceAll(',', "");
    final expression2 = expression1.replaceAll('', "");
    final expression3 = expression2.replaceAll('[', "");
    final expression4 = expression3.replaceAll(']', "");
    String value1 = '';
    String value2 = '';
    String value3 = '';
    String value4 = '';
    String value5 = '';
    String value6 = '';
    String value7 = '';
    String value8 = '';
    String value9 = '';
    String value10 = '';
    String value11 = '';
    String value12 = '';
    String value13 = '';
    String value14 = '';
    String value15 = '';
    for (int i = 0; i < expression4.length; i++) {
      if (i == 0) {
        value1 = expression4[i];
      } else if (i == 2) {
        value2 = expression4[i];
      } else if (i == 4) {
        value3 = expression4[i];
      } else if (i == 6) {
        value4 = expression4[i];
      } else if (i == 8) {
        value5 = expression4[i];
      } else if (i == 10) {
        value6 = expression4[i];
      } else if (i == 12) {
        value7 = expression4[i];
      } else if (i == 14) {
        value8 = expression4[i];
      } else if (i == 16) {
        value9 = expression4[i];
      } else if (i == 18) {
        value10 = expression4[i];
      } else if (i == 20) {
        value11 = expression4[i];
      } else if (i == 22) {
        value12 = expression4[i];
      } else if (i == 24) {
        value13 = expression4[i];
      } else if (i == 26) {
        value14 = expression4[i];
      } else if (i == 28) {
        value15 = expression4[i];
      } else {}
    }
    final expression = value1 +
        value2 +
        value3 +
        value4 +
        value5 +
        value6 +
        value7 +
        value8 +
        value9 +
        value10 +
        value11 +
        value12 +
        value13 +
        value14 +
        value15;
    return expression;
  }
}
