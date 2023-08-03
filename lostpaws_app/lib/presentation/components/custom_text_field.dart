import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String? hintText;
  final String? extraText;
  final int? maxLines;
  final int? minLines;
  final IconData? icon;
  final Function? iconOnPressed;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function? onChanged;
  final double? width;

  const CustomTextField({
    super.key,
    required this.title,
    this.hintText,
    this.extraText,
    this.icon,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.maxLines,
    this.minLines,
    this.iconOnPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const LostPawsText().primaryRegularGreen,
          ),
          SizedBox(height: getProportionateScreenHeight(defaultPadding)),
          Row(
            children: [
              SizedBox(
                width: width,
                child: TextFormField(
                  keyboardType: keyboardType,
                  minLines: minLines,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: hintText,
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validator,
                ),
              ),
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          if (iconOnPressed != null) {
                            iconOnPressed!();
                          }
                        },
                        icon: Icon(
                          icon,
                          color: ConstColors.darkOrange,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              extraText != null
                  ? Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Text(
                        extraText!,
                        style: const LostPawsText().primarySemiBoldGreen,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
