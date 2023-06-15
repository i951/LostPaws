import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class ErrorMessage extends StatelessWidget {
  final String error;

  const ErrorMessage({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(7),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: ConstColors.red,
          ),
          child: Row(
            children: [
              const SizedBox(width: 3),
              const Icon(
                Icons.warning_amber,
                color: ConstColors.darkGreen,
              ),
              const SizedBox(width: defaultPadding),
              Flexible(
                child: Text(
                  error,
                  style: const LostPawsText().primaryRegularGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
