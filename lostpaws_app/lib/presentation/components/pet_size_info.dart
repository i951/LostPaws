import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class PetSizeInfo extends StatelessWidget {
  const PetSizeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.info,
        color: ConstColors.darkGreen,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            insetPadding: const EdgeInsets.all(defaultPadding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - (defaultPadding * 2),
              height: MediaQuery.of(context).size.height - (defaultPadding * 8),
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Need help deciding the animal's size?",
                      style: LostPawsText().primaryTitle,
                    ),
                    Text(
                      'Try referring to the diagrams below.',
                      style: LostPawsText().primaryRegularGrey,
                    ),
                    SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox.square(
                              dimension: 150,
                              child: Image.asset(
                                  'assets/images/mini-example.jpg',
                                  fit: BoxFit.contain),
                            ),
                            Text(
                              'Mini',
                              style: LostPawsText().primaryTitle,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox.square(
                              dimension: 150,
                              child: Image.asset(
                                  'assets/images/small-example.jpg',
                                  fit: BoxFit.contain),
                            ),
                            Text(
                              'Small',
                              style: LostPawsText().primaryTitle,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox.square(
                              dimension: 150,
                              child: Image.asset(
                                  'assets/images/medium-example.jpg',
                                  fit: BoxFit.contain),
                            ),
                            Text(
                              'Medium',
                              style: LostPawsText().primaryTitle,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox.square(
                              dimension: 150,
                              child: Image.asset(
                                  'assets/images/large-example.jpg',
                                  fit: BoxFit.contain),
                            ),
                            Text(
                              'Large',
                              style: LostPawsText().primaryTitle,
                            )
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: ConstColors.darkGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Got it",
                                style: const LostPawsText().primaryRegularWhite,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
