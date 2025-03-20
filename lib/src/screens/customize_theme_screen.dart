import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/light_theme.dart';
import 'package:learning_flutter/src/themes/theme_colors.dart';
import 'package:learning_flutter/src/utils/global_values.dart';
import 'package:learning_flutter/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomizeThemeScreen extends StatefulWidget {
  const CustomizeThemeScreen({super.key});

  @override
  State<CustomizeThemeScreen> createState() => _CustomizeThemeScreenState();
}

class _CustomizeThemeScreenState extends State<CustomizeThemeScreen> {
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
                  // _buildSelectFont(),
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
    final themeProvider = Provider.of<ThemeProvider>(context);

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
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      () => themeProvider.updateColorMode(ColorMode.light),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        themeProvider.colorMode == ColorMode.light
                            ? Theme.of(context).primaryColorLight
                            : Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
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
                            // color: Theme.of(context).colorScheme.onSurface,
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
                  onPressed:
                      () => themeProvider.updateColorMode(ColorMode.dark),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        themeProvider.colorMode == ColorMode.dark
                            ? Theme.of(context).primaryColorLight
                            : Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
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
        ],
      ),
    );
  }

  Widget _buildColorPicker() {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                        themeProvider.updateThemeColor(ThemeColor.defaultTheme);
                      },
                      backgroundColor:
                          themeProvider.themeColor == ThemeColor.defaultTheme
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFF007AAD)),
                      label: Text(
                        'Default',
                        style: TextStyle(
                          color:
                              themeProvider.themeColor ==
                                      ThemeColor.defaultTheme
                                  ? LightTheme.textPrimary
                                  : null,
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
                        themeProvider.updateThemeColor(ThemeColor.sunsetOrange);
                      },
                      backgroundColor:
                          themeProvider.themeColor == ThemeColor.sunsetOrange
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFFFF5733)),
                      label: Text(
                        'Sunset orange',
                        style: TextStyle(
                          color:
                              themeProvider.themeColor ==
                                      ThemeColor.sunsetOrange
                                  ? LightTheme.textPrimary
                                  : null,
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
                        themeProvider.updateThemeColor(ThemeColor.emeraldGreen);
                      },
                      backgroundColor:
                          themeProvider.themeColor == ThemeColor.emeraldGreen
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFF2ECC71)),
                      label: Text(
                        'Emerald green',
                        style: TextStyle(
                          color:
                              themeProvider.themeColor ==
                                      ThemeColor.emeraldGreen
                                  ? LightTheme.textPrimary
                                  : null,
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
                        themeProvider.updateThemeColor(ThemeColor.royalPurple);
                      },
                      backgroundColor:
                          themeProvider.themeColor == ThemeColor.royalPurple
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFF6C5CE7)),
                      label: Text(
                        'Royal purple',
                        style: TextStyle(
                          color:
                              themeProvider.themeColor == ThemeColor.royalPurple
                                  ? LightTheme.textPrimary
                                  : null,
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
                        themeProvider.updateThemeColor(ThemeColor.goldenYellow);
                      },
                      backgroundColor:
                          themeProvider.themeColor == ThemeColor.goldenYellow
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFFFFC300)),
                      label: Text(
                        'Golden yellow',
                        style: TextStyle(
                          color:
                              themeProvider.themeColor ==
                                      ThemeColor.goldenYellow
                                  ? LightTheme.textPrimary
                                  : null,
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
                        themeProvider.updateThemeColor(ThemeColor.midnightDark);
                      },
                      backgroundColor:
                          themeProvider.themeColor == ThemeColor.midnightDark
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).colorScheme.surface,
                      avatar: CircleAvatar(backgroundColor: Color(0xFF212529)),
                      label: Text(
                        'Midnight dark',
                        style: TextStyle(
                          color:
                              themeProvider.themeColor ==
                                      ThemeColor.midnightDark
                                  ? LightTheme.textPrimary
                                  : null,
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

  // Widget _buildSelectFont() {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         const Text(
  //           'Custom Font',
  //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  //         ),
  //         const SizedBox(height: 10),
  //         const Text(
  //           'Select custom font for your workspace',
  //           style: TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.w300,
  //             height: 1.5,
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Theme.of(context).colorScheme.surface,
  //             borderRadius: BorderRadius.circular(5),
  //           ),
  //           child: DropdownButtonHideUnderline(
  //             child: DropdownButton<String>(
  //               value: currentTextTheme,
  //               isExpanded: true,
  //               padding: const EdgeInsets.symmetric(horizontal: 12),
  //               items: const [
  //                 DropdownMenuItem(value: 'Roboto', child: Text('Roboto')),
  //                 DropdownMenuItem(value: 'Lato', child: Text('Lato')),
  //                 DropdownMenuItem(
  //                   value: 'Open Sans',
  //                   child: Text('Open Sans'),
  //                 ),
  //                 DropdownMenuItem(
  //                   value: 'Montserrat',
  //                   child: Text('Montserrat'),
  //                 ),
  //                 DropdownMenuItem(value: 'Poppins', child: Text('Poppins')),
  //               ],
  //               onChanged: (String? value) {
  //                 changeFontFamily(value!);
  //               },
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
