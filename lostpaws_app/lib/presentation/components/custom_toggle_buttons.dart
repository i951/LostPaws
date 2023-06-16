import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/size_config.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class CustomToggleButtons extends StatefulWidget {
  final bool multiselect;
  final List<String> options;

  const CustomToggleButtons({
    super.key,
    required this.multiselect,
    required this.options,
  });

  @override
  State<CustomToggleButtons> createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  List<bool> _selectedItems = [];
  List<Map<String, dynamic>> toggleButtons = [];

  @override
  void initState() {
    super.initState();

    final listSize = widget.options.length;

    _selectedItems = List<bool>.filled(
      listSize,
      false,
      growable: false,
    );

    toggleButtons = List<Map<String, dynamic>>.filled(listSize, {});

    for (var i = 0; i < listSize; i++) {
      toggleButtons[i] = {
        "text": widget.options[i],
        "selected": _selectedItems[i],
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        splashColor: Colors.transparent,
        fillColor: ConstColors.lightGreen,
        renderBorder: false,
        direction: Axis.horizontal,
        onPressed: (int index) {
          setState(() {
            if (!widget.multiselect) {
              // The button that is tapped is set to true, and the others to false.
              for (int i = 0; i < _selectedItems.length; i++) {
                toggleButtons[i]["selected"] = (i == index);
              }
            } else {
              toggleButtons[index]["selected"] =
                  !toggleButtons[index]["selected"];
            }
          });
        },
        isSelected: _selectedItems,
        children: [
          for (var button in toggleButtons)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 8,
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: button["selected"]
                        ? ConstColors.darkOrange
                        : ConstColors.lightOrange),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenWidth(5),
                      horizontal: getProportionateScreenWidth(15)),
                  child: Text(
                    button["text"],
                    style: button["selected"]
                        ? const LostPawsText().primarySemiBoldGreen
                        : const LostPawsText().primaryRegularOrange,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
