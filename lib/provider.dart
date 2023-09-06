import 'package:flutter_riverpod/flutter_riverpod.dart';

final displayProvider =
    NotifierProvider<DisplayNotifier, String>(() => DisplayNotifier());

class DisplayNotifier extends Notifier<String> {
  bool _hasCalculated = false;

  @override
  String build() {
    return '';
  }

  void update(String text) {
    final ops = ['+', '-', '×', '÷'];
    String temp = state;
    if (_hasCalculated && !ops.contains(text) && text != '=') {
      temp = '';
      _hasCalculated = false;
    }
    if (text == 'C') {
      temp = '';
    } else if (text == '\u232B ') {
      if (temp.isNotEmpty) temp = temp.substring(0, temp.length - 1);
    } else if (text == '.') {
      if (temp.isEmpty) {
        temp = '0.';
      } else if (noDot(temp)) {
        temp += '.';
      }
    } else if (ops.contains(text)) {
      if (temp.isEmpty) return;
      if (temp.length < 2 || !ops.contains(temp[temp.length - 1])) {
        temp += text;
      }
    } else if (text == '=') {
      temp = calculate(temp);
    } else {
      temp += text;
    }
    state = temp;
  }

  bool noDot(String temp) {
    final ops = ['+', '-', '×', '÷'];
    for (int i = temp.length - 1; i >= 0; i--) {
      if (ops.contains(temp[i])) return true;
      if (temp[i] == '.') return false;
    }
    return true;
  }

  String calculate(String temp) {
    if (_hasCalculated) return temp;
    final nums = temp
        .split(RegExp(r'[+÷\-\u00d7]'))
        .map((e) => double.parse(e))
        .toList();
    final op = temp
        .split(RegExp(r'[0-9.]'))
        .where((element) => element.isNotEmpty)
        .toList();
    while (op.contains('×') || op.contains('÷')) {
      for (int i = 0; i < op.length; i++) {
        if (op[i] == '×') {
          nums[i] *= nums[i + 1];
          nums.removeAt(i + 1);
          op.removeAt(i);
        } else if (op[i] == '÷') {
          nums[i] /= nums[i + 1];
          nums.removeAt(i + 1);
          op.removeAt(i);
        }
      }
    }
    while (op.isNotEmpty) {
      if (op[0] == '+') {
        nums[0] += nums[1];
      } else if (op[0] == '-') {
        nums[0] -= nums[1];
      }
      nums.removeAt(1);
      op.removeAt(0);
    }
    _hasCalculated = true;
    if (nums[0] == nums[0].roundToDouble()) {
      return nums[0].round().toString();
    } else {
      return nums[0].toString();
    }
  }
}
