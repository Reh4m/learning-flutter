import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/theme.dart';
import 'package:learning_flutter/src/themes/theme_manager.dart';
import 'package:learning_flutter/src/utils/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomizeThemeScreen extends StatefulWidget {
  const CustomizeThemeScreen({super.key});

  @override
  State<CustomizeThemeScreen> createState() => _CustomizeThemeScreenState();
}

class _CustomizeThemeScreenState extends State<CustomizeThemeScreen> {
  Future<void> changeColorMode(ColorMode mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ThemeColor currentThemeColor = GlobalValues.themeColor.value;

    CustomTheme currentCustomTheme = ThemeManager.getTheme(currentThemeColor);

    if (mode == ColorMode.light) {
      GlobalValues.colorMode.value = ColorMode.light;
      GlobalValues.themeApp.value = ThemeManager.getThemeInstance(
        currentCustomTheme,
        ColorMode.light,
      );
      await prefs.setString('theme', 'light');
    }

    if (mode == ColorMode.dark) {
      GlobalValues.colorMode.value = ColorMode.dark;
      GlobalValues.themeApp.value = ThemeManager.getThemeInstance(
        currentCustomTheme,
        ColorMode.dark,
      );
      await prefs.setString('theme', 'dark');
    }
  }

  Future<void> changeColorTheme(ThemeColor mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    CustomTheme customTheme = ThemeManager.getTheme(mode);

    ThemeData darkThemeInstance = AppTheme.darkTheme.copyWith(
      primaryColor: customTheme.primaryColor,
      primaryColorLight: customTheme.primaryColorLight,
      colorScheme: AppTheme.darkTheme.colorScheme.copyWith(
        primary: customTheme.primaryColor,
        secondary: customTheme.primaryColorLight,
      ),
    );

    ThemeData lightThemeInstance = AppTheme.lightTheme.copyWith(
      primaryColor: customTheme.primaryColor,
      primaryColorLight: customTheme.primaryColorLight,
      colorScheme: AppTheme.lightTheme.colorScheme.copyWith(
        primary: customTheme.primaryColor,
        secondary: customTheme.primaryColorLight,
      ),
    );

    if (GlobalValues.colorMode.value == ColorMode.light) {
      GlobalValues.themeApp.value = lightThemeInstance;
    }

    if (GlobalValues.colorMode.value == ColorMode.dark) {
      GlobalValues.themeApp.value = darkThemeInstance;
    }

    GlobalValues.themeColor.value = mode;

    await prefs.setString('themeColor', mode.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(),
                  _buildSelectTheme(),
                  _buildColorPicker(),
                  _buildSelectFont(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
            padding: const EdgeInsets.all(10.0),
          ),
          Text(
            'Customize Theme',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectTheme() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Color Mode',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Text(
            'Choose if app\'s appearance should be light or dark, or follow system settings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: GlobalValues.colorMode,
            builder:
                (context, value, child) => Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => changeColorMode(ColorMode.light),

                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              value == ColorMode.light
                                  ? Theme.of(context).primaryColorLight
                                  : Theme.of(context).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.light_mode),
                              const SizedBox(width: 10),
                              const Text(
                                'Light mode',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => changeColorMode(ColorMode.dark),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              value == ColorMode.dark
                                  ? Theme.of(context).primaryColorLight
                                  : Theme.of(context).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.dark_mode),
                              const SizedBox(width: 10),
                              const Text(
                                'Dark mode',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Custom theme',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Text(
            'Choose a preferred color scheme for the app',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: GlobalValues.themeColor,
            builder:
                (context, value, child) => Wrap(
                  spacing: 10,
                  children: <Widget>[
                    ActionChip(
                      onPressed: () {
                        changeColorTheme(ThemeColor.defaultTheme);
                      },
                      backgroundColor:
                          value == ThemeColor.defaultTheme
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFF007AAD)),
                      label: const Text(
                        'Default',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide.none,
                    ),
                    ActionChip(
                      onPressed: () {
                        changeColorTheme(ThemeColor.sunsetOrange);
                      },
                      backgroundColor:
                          value == ThemeColor.sunsetOrange
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFFFF5733)),
                      label: const Text(
                        'Sunset orange',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide.none,
                    ),
                    ActionChip(
                      onPressed: () {
                        changeColorTheme(ThemeColor.emeraldGreen);
                      },
                      backgroundColor:
                          value == ThemeColor.emeraldGreen
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFF2ECC71)),
                      label: const Text(
                        'Emerald green',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide.none,
                    ),
                    ActionChip(
                      onPressed: () {
                        changeColorTheme(ThemeColor.royalPurple);
                      },
                      backgroundColor:
                          value == ThemeColor.royalPurple
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFF6C5CE7)),
                      label: const Text(
                        'Royal purple',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide.none,
                    ),
                    ActionChip(
                      onPressed: () {
                        changeColorTheme(ThemeColor.goldenYellow);
                      },
                      backgroundColor:
                          value == ThemeColor.goldenYellow
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFFFFC300)),
                      label: const Text(
                        'Golden yellow',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide.none,
                    ),
                    ActionChip(
                      onPressed: () {
                        changeColorTheme(ThemeColor.midnight);
                      },
                      backgroundColor:
                          value == ThemeColor.midnight
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFF212529)),
                      label: const Text(
                        'Midnight dark',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide.none,
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectFont() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Custom Font',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Text(
            'Select custom font for your workspace',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
