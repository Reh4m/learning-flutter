import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/src/screens/appearance/customize_theme/widgets/theme_mode_selector_widget.dart';
import 'package:learning_flutter/src/screens/appearance/customize_theme/widgets/theme_font_selector_widget.dart';
import 'package:learning_flutter/src/screens/appearance/customize_theme/widgets/theme_color_selector_widget.dart';

class CustomizeThemeScreen extends StatelessWidget {
  const CustomizeThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customize Theme')),
      body: const SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ThemeModeSelectorWidget(),
                    SizedBox(height: 20.0),
                    ThemeColorSelectorWidget(),
                    SizedBox(height: 20.0),
                    ThemeFontSelectorWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
