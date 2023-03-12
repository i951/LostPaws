// Flutter imports:
import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';

/// A Theme Extension for managing [TextStyle]s through the entire app.
class LostPawsText extends ThemeExtension<LostPawsText> {
  const LostPawsText();

  @override
  ThemeExtension<LostPawsText> copyWith() {
    return this;
  }

  @override
  ThemeExtension<LostPawsText> lerp(
      ThemeExtension<LostPawsText>? other, double t) {
    return this;
  }

  /// The largest title style used on the login screen, 56pt semiBold.
  TextStyle get title {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 56,
      height: 1.2,
      color: Colors.black,
    );
  }

  /// The 2nd largest title style used on the Create Account screen.
  TextStyle get title2 {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 40,
      height: 1.2,
      color: Colors.black,
    );
  }

  /// The 3rd largest title style used on the Forgot Password screen.
  TextStyle get title3 {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 38,
      height: 1.2,
      color: Colors.black,
    );
  }

  /// The primary title style for main titles, 24pt semiBold.
  TextStyle get primaryTitle {
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 1.2,
      color: Colors.black,
    );
  }

  /// Regular text, 16pt normal.
  TextStyle get primaryRegular {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.5,
      color: Colors.black,
    );
  }

  /// Regular semibold text, 16pt semiBold.
  TextStyle get primarySemiBold {
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1.5,
      color: Colors.black,
    );
  }

  /// Regular semibold text with shadow, 18pt semiBold.
  TextStyle get primarySemiBoldShadow {
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 1.5,
      color: Colors.black,
      shadows: [
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 8.0,
          color: ConstColors.lightGrey,
        ),
      ],
    );
  }

  /// Regular italic bolded text, 16pt italic semiBold.
  TextStyle get primaryOrangeBold {
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1.5,
      color: ConstColors.darkOrange,
    );
  }

  /// Regular italic text, 16pt italic.
  TextStyle get primaryItalic {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      fontSize: 16,
      height: 1.5,
      color: Colors.black,
    );
  }

  /// For really standout numbers, 36pt semiBold.
  TextStyle get titleNumbers {
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 30,
      height: 1.2,
      color: Colors.black,
    );
  }

  // 12 pt semiBold font.
  TextStyle get caption1SemiBold {
    return const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      height: 1.2,
      color: Colors.black,
    );
  }

  TextStyle get caption1Regular {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.2,
      color: Colors.black,
    );
  }
}
