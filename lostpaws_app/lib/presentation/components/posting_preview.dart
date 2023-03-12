// Flutter imports:
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class PostingPreview extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final String time;
  final String city;
  final String province;

  const PostingPreview({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
    required this.time,
    required this.city,
    required this.province,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
        onTap: () {
          print("tapped");
        },
        child: Container(
          height: getProportionateScreenHeight(250),
          width: getProportionateScreenWidth(180),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: getProportionateScreenWidth(180),
                height: getProportionateScreenHeight(140),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(
                      getProportionateScreenHeight(defaultPadding)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7.0),
                        child: Text(
                          "$title",
                          style: const LostPawsText().caption1SemiBold,
                        ),
                      ),
                      Text(
                        "Last seen:\n$date at $time\n$city, $province",
                        style: const LostPawsText().caption1Regular,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
