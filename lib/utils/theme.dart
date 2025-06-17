import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// A utility class that provides theme configuration for the app
class AppTheme {
  /// Primary color for the app
  static const Color primaryColor = Color(0xFF2563EB);

  /// Secondary color for the app
  static const Color secondaryColor = Color(0xFF3B82F6);

  /// Accent color for the app
  static const Color accentColor = Color(0xFF60A5FA);

  /// Background color for the app
  static const Color backgroundColor = Color(0xFFF8FAFC);

  /// Surface color for the app
  static const Color surfaceColor = Colors.white;

  /// Text color for the app
  static const Color textColor = Color(0xFF1E293B);

  /// Light text color for the app
  static const Color textLightColor = Color(0xFF64748B);

  /// Error color for the app
  static const Color errorColor = Color(0xFFEF4444);

  /// Success color for the app
  static const Color successColor = Color(0xFF22C55E);

  /// Warning color for the app
  static const Color warningColor = Color(0xFFF59E0B);

  /// Dark theme colors
  static const Color darkPrimaryColor = Color(0xFF90CAF9);
  static const Color darkSecondaryColor = Color(0xFF42A5F5);
  static const Color darkBackgroundColor = Color(0xFF0F172A);
  static const Color darkSurfaceColor = Color(0xFF1E293B);
  static const Color darkErrorColor = Color(0xFFEF5350);

  /// Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  /// Border Radius
  static const double borderRadius = 16.0;
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusLarge = 24.0;

  /// Spacing
  static const double spacing = 16.0;
  static const double spacingSmall = 8.0;
  static const double spacingLarge = 24.0;

  /// Text Styles
  static TextStyle get heading1 => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textColor,
    height: 1.2,
  );

  static TextStyle get heading2 => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textColor,
    height: 1.3,
  );

  static TextStyle get heading3 => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textColor,
    height: 1.4,
  );

  static TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 16, color: textColor, height: 1.5);

  static TextStyle get bodyMedium =>
      GoogleFonts.inter(fontSize: 14, color: textColor, height: 1.5);

  static TextStyle get bodySmall =>
      GoogleFonts.inter(fontSize: 12, color: textLightColor, height: 1.5);

  static TextStyle get button => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.5,
    letterSpacing: 0.5,
  );

  /// Returns the light theme for the app
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor,
        onBackground: textColor,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: heading3,
        iconTheme: const IconThemeData(color: textColor),
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: heading1,
        displayMedium: heading2,
        displaySmall: heading3,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: button,
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.all(spacing),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: errorColor),
        ),
        hintStyle: bodyMedium.copyWith(color: textLightColor),
        errorStyle: bodySmall.copyWith(color: errorColor),
        prefixIconColor: textLightColor,
        suffixIconColor: textLightColor,
        isDense: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingLarge,
            vertical: spacing,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle: button,
          elevation: 0,
          minimumSize: const Size(88, 48),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingLarge,
            vertical: spacing,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: const BorderSide(color: primaryColor),
          textStyle: button.copyWith(color: primaryColor),
          minimumSize: const Size(88, 48),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: spacing,
            vertical: spacingSmall,
          ),
          textStyle: button.copyWith(color: primaryColor),
          minimumSize: const Size(88, 36),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textLightColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 12),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        sizeConstraints: const BoxConstraints(minWidth: 56, minHeight: 56),
        iconSize: 24,
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE2E8F0),
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceColor,
        contentTextStyle: bodyMedium.copyWith(color: textColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        behavior: SnackBarBehavior.floating,
        actionTextColor: primaryColor,
        elevation: 0,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(borderRadiusSmall),
          boxShadow: cardShadow,
        ),
        textStyle: bodySmall.copyWith(color: textColor),
        padding: const EdgeInsets.symmetric(
          horizontal: spacing,
          vertical: spacingSmall,
        ),
        preferBelow: true,
        verticalOffset: 8,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return Colors.transparent;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
        side: const BorderSide(color: textLightColor),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return textLightColor;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return Colors.white;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor.withOpacity(0.5);
          }
          return textLightColor.withOpacity(0.5);
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
        linearTrackColor: Color(0xFFE2E8F0),
        circularTrackColor: Color(0xFFE2E8F0),
      ),
    );
  }

  /// Returns the dark theme for the app
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: darkSurfaceColor,
        background: darkBackgroundColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: darkBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: darkSurfaceColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: heading3.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: heading1.copyWith(color: Colors.white),
            displayMedium: heading2.copyWith(color: Colors.white),
            displaySmall: heading3.copyWith(color: Colors.white),
            bodyLarge: bodyLarge.copyWith(color: Colors.white),
            bodyMedium: bodyMedium.copyWith(color: Colors.white),
            bodySmall: bodySmall.copyWith(color: Colors.white70),
            labelLarge: button,
          ),
      cardTheme: CardThemeData(
        color: darkSurfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceColor,
        contentPadding: const EdgeInsets.all(spacing),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: errorColor),
        ),
        hintStyle: bodyMedium.copyWith(color: Colors.white70),
        errorStyle: bodySmall.copyWith(color: errorColor),
        prefixIconColor: Colors.white70,
        suffixIconColor: Colors.white70,
        isDense: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingLarge,
            vertical: spacing,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle: button,
          elevation: 0,
          minimumSize: const Size(88, 48),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingLarge,
            vertical: spacing,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: const BorderSide(color: primaryColor),
          textStyle: button.copyWith(color: primaryColor),
          minimumSize: const Size(88, 48),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: spacing,
            vertical: spacingSmall,
          ),
          textStyle: button.copyWith(color: primaryColor),
          minimumSize: const Size(88, 36),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 12),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        sizeConstraints: const BoxConstraints(minWidth: 56, minHeight: 56),
        iconSize: 24,
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF334155),
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkSurfaceColor,
        contentTextStyle: bodyMedium.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        behavior: SnackBarBehavior.floating,
        actionTextColor: primaryColor,
        elevation: 0,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: darkSurfaceColor,
          borderRadius: BorderRadius.circular(borderRadiusSmall),
          boxShadow: cardShadow,
        ),
        textStyle: bodySmall.copyWith(color: Colors.white),
        padding: const EdgeInsets.symmetric(
          horizontal: spacing,
          vertical: spacingSmall,
        ),
        preferBelow: true,
        verticalOffset: 8,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return Colors.transparent;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
        side: const BorderSide(color: Colors.white70),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return Colors.white70;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return Colors.white;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor.withOpacity(0.5);
          }
          return Colors.white70.withOpacity(0.5);
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
        linearTrackColor: Color(0xFF334155),
        circularTrackColor: Color(0xFF334155),
      ),
    );
  }

  // Glassmorphism styles
  static BoxDecoration glassmorphismDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Neumorphism styles
  static BoxDecoration neumorphismDecoration = BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.8),
        offset: const Offset(-6, -6),
        blurRadius: 12,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        offset: const Offset(6, 6),
        blurRadius: 12,
      ),
    ],
  );

  // Dark neumorphism styles
  static BoxDecoration darkNeumorphismDecoration = BoxDecoration(
    color: darkBackgroundColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.05),
        offset: const Offset(-6, -6),
        blurRadius: 12,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        offset: const Offset(6, 6),
        blurRadius: 12,
      ),
    ],
  );
}
