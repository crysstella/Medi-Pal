import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  
  const AppTheme();


  /// Default `ThemeData` for App UI.
  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      // primaryColor: AppColors.primaryPurple,
      // canvasColor: _backgroundColor,
      // scaffoldBackgroundColor: _backgroundColor,
      // iconTheme: _iconTheme,
      // appBarTheme: _appBarTheme,
      // dividerTheme: _dividerTheme,
       //textTheme: _textTheme,
        textTheme: GoogleFonts.chivoTextTheme(),
      //textTheme: GoogleFonts.recursiveTextTheme(),
      // inputDecorationTheme: _inputDecorationTheme,
      // buttonTheme: _buttonTheme,
      // splashColor: AppColors.transparent,
      // snackBarTheme: _snackBarTheme,
      // elevatedButtonTheme: _elevatedButtonTheme,
      // textButtonTheme: _textButtonTheme,
      colorScheme: _colorScheme,
      // bottomSheetTheme: _bottomSheetTheme,
      // listTileTheme: _listTileTheme,
      // switchTheme: _switchTheme,
      // progressIndicatorTheme: _progressIndicatorTheme,
      // tabBarTheme: _tabBarTheme,
      // bottomNavigationBarTheme: _bottomAppBarTheme,
      // chipTheme: _chipTheme,


    
    );
  }

  ColorScheme get _colorScheme {
    return const ColorScheme.light(
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
      onInverseSurface: Color(4294176759),
      inversePrimary: Color(4290888191),
    );
  }






  // TextTheme get _textTheme => uiTextTheme;

  // /// The Content text theme based on [ContentTextStyle].
  // static final contentTextTheme = TextTheme(
  //   displayLarge: ContentTextStyle.headline1,
  //   displayMedium: ContentTextStyle.headline2,
  //   displaySmall: ContentTextStyle.headline3,
  //   headlineMedium: ContentTextStyle.headline4,
  //   headlineSmall: ContentTextStyle.headline5,
  //   titleLarge: ContentTextStyle.headline6,
  //   titleMedium: ContentTextStyle.subtitle1,
  //   titleSmall: ContentTextStyle.subtitle2,
  //   bodyLarge: ContentTextStyle.bodyText1,
  //   bodyMedium: ContentTextStyle.bodyText2,
  //   labelLarge: ContentTextStyle.button,
  //   bodySmall: ContentTextStyle.caption,
  //   labelSmall: ContentTextStyle.overline, 
  // // ).apply(
  // //   bodyColor: Color(),
  // //   displayColor: AppColors.black,
  // //   decorationColor: AppColors.black,
  // );

  // /// The UI text theme based on [UITextStyle].
  // static final uiTextTheme = TextTheme(
  //   displayLarge: UITextStyle.headline1,
  //   displayMedium: UITextStyle.headline2,
  //   displaySmall: UITextStyle.headline3,
  //   headlineMedium: UITextStyle.headline4,
  //   headlineSmall: UITextStyle.headline5,
  //   titleLarge: UITextStyle.headline6,
  //   titleMedium: UITextStyle.subtitle1,
  //   titleSmall: UITextStyle.subtitle2,
  //   bodyLarge: UITextStyle.bodyText1,
  //   bodyMedium: UITextStyle.bodyText2,
  //   labelLarge: UITextStyle.button,
  //   bodySmall: UITextStyle.caption,
  //   labelSmall: UITextStyle.overline,
  // // ).apply(
  // //   bodyColor: AppColors.black,
  // //   displayColor: AppColors.black,
  // //   decorationColor: AppColors.black,
  // );




  // ProgressIndicatorThemeData get _progressIndicatorTheme {
  //   return const ProgressIndicatorThemeData(
  //     color: AppColors.darkAqua,
  //     circularTrackColor: AppColors.borderOutline,
  //   );
  // }


}




// Dark Mode App [ThemeData].
class AppDarkTheme extends AppTheme {
 
  const AppDarkTheme();

  @override
  ColorScheme get _colorScheme {
    return const ColorScheme.dark().copyWith(
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
      onInverseSurface: Color(4281348150),
      inversePrimary: Color(4283980178),
    );
  }

}

