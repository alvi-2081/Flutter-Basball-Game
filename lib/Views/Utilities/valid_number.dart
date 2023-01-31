import 'dart:math';

class NumberCheck {
  static bool isNumeric(String x) {
    List<String> validChar = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
    for (int i = 0; i < x.length; i++) {
      return validChar.contains(x[i]);
    }
    return false;
  }

  static int randomDigit() {
    int a, b, c;
    a = random();
    b = random();
    c = random();

    print('First time a: $a, b: $b, c: $c');

    if (a == c || a == b) {
      if (a < 6) {
        if (a + 1 == b || a + 1 == c) {
          a = a + 2;
        } else {
          a = a + 1;
        }
      } else {
        if (a - 1 == b || a - 1 == c) {
          a = a - 2;
        } else {
          a = a - 1;
        }
      }
    }

    if (b == c) {
      if (b < 6) {
        if (b + 1 == a) {
          b = b + 2;
        } else {
          b = b + 1;
        }
      } else {
        if (b - 1 == a) {
          b = b - 2;
        } else {
          b = b - 1;
        }
      }
    }
    print('Second time a: $a, b: $b, c: $c');
    return a * 100 + b * 10 + c;
  }

  static int random() {
    Random rnd;
    int min = 0;
    int max = 9;
    rnd = Random();
    int r = min + rnd.nextInt(max - min);
    return r;
  }
}
