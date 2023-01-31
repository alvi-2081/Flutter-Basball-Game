import 'package:baseball_game/Views/Utilities/valid_number.dart';
import 'package:flutter/material.dart';

class EditGuess extends StatelessWidget {
  EditGuess({Key? key, required this.controller}) : super(key: key);

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    bool hasRepeatedDigits = false;
    return TextFormField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Enter your guess (3 digits)',
        suffixIcon: _iconSuffix(controller),
        hintStyle: const TextStyle(
          fontSize: 20,
        ),
      ),
      style: const TextStyle(
        fontSize: 20,
      ),
      controller: controller,
      validator: (value) {
        hasRepeatedDigits = false;
        if (value!.isEmpty) {
          return 'Please enter a number';
        } else {
          if (value.length == 3) {
            if (NumberCheck.isNumeric(value)) {
              var input = value;
              var chars = input.toLowerCase().split('');
              var counts = <String, int>{};
              for (var char in chars) {
                counts[char] = (counts[char] ?? 0) + 1;
              }
              for (var value in counts.values) {
                if (value > 1) {
                  hasRepeatedDigits = true;
                }
              }

              if (hasRepeatedDigits) {
                return 'Invalid! Repeated digits not allowed';
              }
            } else {
              return 'Invalid! Only numbers allowed';
            }
          } else {
            return 'Invalid! Must be 3 digits';
          }
        }
        return null;
      },
    );
  }
}

Widget _iconSuffix(TextEditingController controller) {
  return IconButton(
    icon: const Icon(
      Icons.cancel,
      color: Colors.black54,
    ),
    onPressed: () {
      controller.clear();
    },
  );
}
