import 'package:freezed_annotation/freezed_annotation.dart';
part 'pet_colour.freezed.dart';
part 'pet_colour.g.dart';

enum PetColours {
  chocolateBrown(
    0xFF795548,
    "Chocolate Brown",
  ),

  tanBrown(
    0xFFD2B48C,
    "Tan Brown",
  ),

  cream(
    0xFFF4E5D2,
    "Cream",
  ),

  gold(
    0xFFE4AC58,
    "Gold",
  ),

  orange(
    0xFFFF9800,
    "Orange",
  ),

  yellowOrange(
    0xFFFFC107,
    "Yellow Orange",
  ),

  yellow(
    0xFFFFEB3B,
    "Yellow",
  ),

  limeGreen(
    0xFFCDDC39,
    "Lime Green",
  ),

  lightGreen(
    0xFF8BC34A,
    "Light Green",
  ),

  green(
    0xFF4CAF50,
    "Green",
  ),

  white(
    0xFFFFFFFF,
    "White",
  ),

  black(
    0xFF000000,
    "Black",
  ),

  grey(
    0xFF9E9E9E,
    "Grey",
  ),

  lightBlue(
    0xFF03A9F4,
    "Light Blue",
  ),

  darkBlue(
    0xFF3F51B5,
    "Dark Blue",
  ),

  red(
    0xFFFF5722,
    "red",
  );

  final int hexValue;
  final String name;

  const PetColours(
    this.hexValue,
    this.name,
  );
}

@freezed
class PetColour with _$PetColour {
  PetColour._();

  factory PetColour({
    /// The HEX value of the colour
    @JsonKey(name: 'hexValue') required int hexValue,

    /// The name that describes the colour
    @JsonKey(name: 'colourName') required String name,
  }) = _PetColour;

  factory PetColour.fromJson(Map<String, dynamic> json) =>
      _$PetColourFromJson(json);
}
