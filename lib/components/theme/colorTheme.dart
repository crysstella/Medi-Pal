import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4283980178),
      surfaceTint: Color(4283980178),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292993023),
      onPrimaryContainer: Color(4279505738),
      secondary: Color(4280904263),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4289655493),
      onSecondaryContainer: Color(4278198544),
      tertiary: Color(4286991216),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957292),
      onTertiaryContainer: Color(4281796394),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294768895),
      onBackground: Color(4279966497),
      surface: Color(4294768895),
      onSurface: Color(4279966497),
      surfaceVariant: Color(4293190124),
      onSurfaceVariant: Color(4282861135),
      outline: Color(4286019200),
      outlineVariant: Color(4291347920),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inverseOnSurface: Color(4294176759),
      inversePrimary: Color(4290888191),
      primaryFixed: Color(4292993023),
      onPrimaryFixed: Color(4279505738),
      primaryFixedDim: Color(4290888191),
      onPrimaryFixedVariant: Color(4282401144),
      secondaryFixed: Color(4289655493),
      onSecondaryFixed: Color(4278198544),
      secondaryFixedDim: Color(4287878570),
      onSecondaryFixedVariant: Color(4278800689),
      tertiaryFixed: Color(4294957292),
      onTertiaryFixed: Color(4281796394),
      tertiaryFixedDim: Color(4294554075),
      onTertiaryFixedVariant: Color(4285150295),
      surfaceDim: Color(4292663776),
      surfaceBright: Color(4294768895),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294374138),
      surfaceContainer: Color(4293979380),
      surfaceContainerHigh: Color(4293584879),
      surfaceContainerHighest: Color(4293190121),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4282137972),
      surfaceTint: Color(4283980178),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4285427626),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278340909),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282483036),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4284887123),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4288635271),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294768895),
      onBackground: Color(4279966497),
      surface: Color(4294768895),
      onSurface: Color(4279966497),
      surfaceVariant: Color(4293190124),
      onSurfaceVariant: Color(4282597963),
      outline: Color(4284440167),
      outlineVariant: Color(4286282115),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inverseOnSurface: Color(4294176759),
      inversePrimary: Color(4290888191),
      primaryFixed: Color(4285427626),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283848335),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282483036),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280772677),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4288635271),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4286794093),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292663776),
      surfaceBright: Color(4294768895),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294374138),
      surfaceContainer: Color(4293979380),
      surfaceContainerHigh: Color(4293584879),
      surfaceContainerHighest: Color(4293190121),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4279966545),
      surfaceTint: Color(4283980178),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282137972),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278200597),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4278340909),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282322737),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284887123),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294768895),
      onBackground: Color(4279966497),
      surface: Color(4294768895),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293190124),
      onSurfaceVariant: Color(4280492843),
      outline: Color(4282597963),
      outlineVariant: Color(4282597963),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4293716735),
      primaryFixed: Color(4282137972),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4280690268),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4278340909),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278203421),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284887123),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4283177532),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292663776),
      surfaceBright: Color(4294768895),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294374138),
      surfaceContainer: Color(4293979380),
      surfaceContainerHigh: Color(4293584879),
      surfaceContainerHighest: Color(4293190121),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4290888191),
      surfaceTint: Color(4290888191),
      onPrimary: Color(4280953440),
      primaryContainer: Color(4282401144),
      onPrimaryContainer: Color(4292993023),
      secondary: Color(4287878570),
      onSecondary: Color(4278204704),
      secondaryContainer: Color(4278800689),
      onSecondaryContainer: Color(4289655493),
      tertiary: Color(4294554075),
      onTertiary: Color(4283440704),
      tertiaryContainer: Color(4285150295),
      onTertiaryContainer: Color(4294957292),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279440152),
      onBackground: Color(4293190121),
      surface: Color(4279440152),
      onSurface: Color(4293190121),
      surfaceVariant: Color(4282861135),
      onSurfaceVariant: Color(4291347920),
      outline: Color(4287729562),
      outlineVariant: Color(4282861135),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293190121),
      inverseOnSurface: Color(4281348150),
      inversePrimary: Color(4283980178),
      primaryFixed: Color(4292993023),
      onPrimaryFixed: Color(4279505738),
      primaryFixedDim: Color(4290888191),
      onPrimaryFixedVariant: Color(4282401144),
      secondaryFixed: Color(4289655493),
      onSecondaryFixed: Color(4278198544),
      secondaryFixedDim: Color(4287878570),
      onSecondaryFixedVariant: Color(4278800689),
      tertiaryFixed: Color(4294957292),
      onTertiaryFixed: Color(4281796394),
      tertiaryFixedDim: Color(4294554075),
      onTertiaryFixedVariant: Color(4285150295),
      surfaceDim: Color(4279440152),
      surfaceBright: Color(4281940031),
      surfaceContainerLowest: Color(4279111187),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280953135),
      surfaceContainerHighest: Color(4281676858),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4291217151),
      surfaceTint: Color(4290888191),
      onPrimary: Color(4279110981),
      primaryContainer: Color(4287335368),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4288141742),
      onSecondary: Color(4278197005),
      secondaryContainer: Color(4284391031),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294882783),
      onTertiary: Color(4281336356),
      tertiaryContainer: Color(4290673828),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279440152),
      onBackground: Color(4293190121),
      surface: Color(4279440152),
      onSurface: Color(4294834687),
      surfaceVariant: Color(4282861135),
      onSurfaceVariant: Color(4291611092),
      outline: Color(4288979372),
      outlineVariant: Color(4286874252),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293190121),
      inverseOnSurface: Color(4280953135),
      inversePrimary: Color(4282466938),
      primaryFixed: Color(4292993023),
      onPrimaryFixed: Color(4278715969),
      primaryFixedDim: Color(4290888191),
      onPrimaryFixedVariant: Color(4281282662),
      secondaryFixed: Color(4289655493),
      onSecondaryFixed: Color(4278195465),
      secondaryFixedDim: Color(4287878570),
      onSecondaryFixedVariant: Color(4278206244),
      tertiaryFixed: Color(4294957292),
      onTertiaryFixed: Color(4280877086),
      tertiaryFixedDim: Color(4294554075),
      onTertiaryFixedVariant: Color(4283900742),
      surfaceDim: Color(4279440152),
      surfaceBright: Color(4281940031),
      surfaceContainerLowest: Color(4279111187),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280953135),
      surfaceContainerHighest: Color(4281676858),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294834687),
      surfaceTint: Color(4290888191),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4291217151),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4293918704),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4288141742),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965753),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294882783),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279440152),
      onBackground: Color(4293190121),
      surface: Color(4279440152),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282861135),
      onSurfaceVariant: Color(4294834687),
      outline: Color(4291611092),
      outlineVariant: Color(4291611092),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293190121),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4280492889),
      primaryFixed: Color(4293321983),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4291217151),
      onPrimaryFixedVariant: Color(4279110981),
      secondaryFixed: Color(4289918665),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4288141742),
      onSecondaryFixedVariant: Color(4278197005),
      tertiaryFixed: Color(4294958830),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294882783),
      onTertiaryFixedVariant: Color(4281336356),
      surfaceDim: Color(4279440152),
      surfaceBright: Color(4281940031),
      surfaceContainerLowest: Color(4279111187),
      surfaceContainerLow: Color(4279966497),
      surfaceContainer: Color(4280229669),
      surfaceContainerHigh: Color(4280953135),
      surfaceContainerHighest: Color(4281676858),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
