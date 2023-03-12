part of main;

/// The [LostPawsText] extension
///
/// Declared outside of [_theme] so it can be referenced
const LostPawsText _lostPawsText = LostPawsText();

/// The Default Theme for the App; accessed via Theme.of(context)
ThemeData get _theme => ThemeData(
      // Theme extensions, accessible via `Theme.of(context).extension<FooClass>()!;`
      extensions: const <ThemeExtension<dynamic>>[
        _lostPawsText,
      ],
      // The default color of the [Material] that underlies the [Scaffold]
      scaffoldBackgroundColor: ConstColors.lightGreen,
      // The default [TextField] or [TextFormField] style. 14pt label, rounded
      // stroke on the border, no color change on selected / unselected.
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ConstColors.lightGrey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ConstColors.darkOrange,
          ),
        ),
      ),
    );
