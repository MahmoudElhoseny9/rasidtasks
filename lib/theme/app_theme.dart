import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rasidtasks/core/constants/defaults.dart';
import 'package:rasidtasks/theme/app_colors.dart';
import 'package:rasidtasks/theme/widgets/app_text_form_field_theme.dart';

class AppTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bgLight,
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.bgSecondayLight,
        surfaceTintColor: AppColors.bgSecondayLight,
      ),
      primaryColor: AppColors.primaryColor,
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          .apply(
              bodyColor: AppColors.titleLight,
              displayColor: AppColors.titleLight)
          .copyWith(
            bodyLarge: const TextStyle(color: AppColors.textLight),
            bodyMedium: const TextStyle(color: AppColors.textLight),
            bodySmall: const TextStyle(color: AppColors.textLight),
          ),
      iconTheme: const IconThemeData(color: AppColors.iconLight),
      dividerColor: AppColors.highlightLight,
      dividerTheme: const DividerThemeData(
        thickness: 1,
        color: AppColors.highlightLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 56),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDefaults.borderRadius),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.titleLight,
          minimumSize: const Size(100, 56),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding16,
            vertical: AppDefaults.padding16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
          ),
          side: const BorderSide(
            color: AppColors.highlightLight,
            width: 2,
          ),
        ),
      ),
      inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
      expansionTileTheme: const ExpansionTileThemeData(
        shape: RoundedRectangleBorder(),
      ),
      badgeTheme: const BadgeThemeData(
        backgroundColor: AppColors.error,
        smallSize: 8,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
            borderSide:
                const BorderSide(width: 2, color: AppColors.highlightLight),
          ),
        ),
      ),
    );
  }
}
