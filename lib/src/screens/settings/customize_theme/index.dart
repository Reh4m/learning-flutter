import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/src/screens/settings/customize_theme/widgets/select_color_mode_widget.dart';
import 'package:learning_flutter/src/screens/settings/customize_theme/widgets/select_custom_font_widget.dart';
import 'package:learning_flutter/src/screens/settings/customize_theme/widgets/select_custom_theme_widget.dart';

class CustomizeThemeScreen extends StatelessWidget {
  const CustomizeThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customize Theme')),
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
                  _buildSelectColorMode(),
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

  Widget _buildSelectColorMode() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SelectColorModeWidget(),
    );
  }

  Widget _buildColorPicker() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SelectCustomThemeWidget(),
    );
  }

  Widget _buildSelectFont() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SelectCustomFontWidget(),
    );
  }
}
