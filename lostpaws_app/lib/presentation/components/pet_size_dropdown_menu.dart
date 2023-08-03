import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostpaws_app/business/bloc/create_post_bloc.dart';
import 'package:lostpaws_app/presentation/constants.dart';
import 'package:lostpaws_app/presentation/theme/lostpaws_text.dart';

class PetSizeDropdownMenu extends StatefulWidget {
  final void Function(String?)? handleOnChanged;

  const PetSizeDropdownMenu({
    super.key,
    required this.handleOnChanged,
  });

  @override
  State<PetSizeDropdownMenu> createState() => _PetSizeDropdownMenuState();
}

class _PetSizeDropdownMenuState extends State<PetSizeDropdownMenu> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      hint: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'select size',
          style: LostPawsText().primarySmallerGrey,
        ),
      ),
      value: selectedSize,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 42,
      underline: const SizedBox(),
      borderRadius: BorderRadius.circular(10),
      items: const [
        DropdownMenuItem(
          value: "Mini",
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text("Mini"),
          ),
        ),
        DropdownMenuItem(
          value: "Small",
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text("Small"),
          ),
        ),
        DropdownMenuItem(
          value: "Medium",
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text("Medium"),
          ),
        ),
        DropdownMenuItem(
          value: "Large",
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text("Large"),
          ),
        ),
      ],
      onChanged: (size) {
        setState(() {
          selectedSize = size;
        });

        context.read<CreatePostBloc>().add(CreatePostSizeChanged(size: size!));
      },
    );
  }
}
