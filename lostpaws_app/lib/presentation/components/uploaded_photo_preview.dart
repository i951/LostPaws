import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';

class UploadedPhotoPreview extends StatefulWidget {
  final String imagePath;
  final int imageIndex;
  final void Function()? onPressed;

  const UploadedPhotoPreview({
    super.key,
    required this.imagePath,
    required this.imageIndex,
    required this.onPressed,
  });

  @override
  State<UploadedPhotoPreview> createState() => _UploadedPhotoPreviewState();
}

class _UploadedPhotoPreviewState extends State<UploadedPhotoPreview> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:
              const EdgeInsets.only(right: defaultPadding, top: defaultPadding),
          width: 100,
          height: 140,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(
              File(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 3,
          right: 8,
          child: GestureDetector(
            onTap: widget.onPressed,
            child: const Icon(
              Icons.cancel,
              color: ConstColors.lightGrey,
            ),
          ),
        ),
      ],
    );
  }
}
