import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/src/screens/settings/cutomize_theme/widgets/select_color_mode_widget.dart';
import 'package:learning_flutter/src/screens/settings/cutomize_theme/widgets/select_custom_theme_widget.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);

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
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: themeProvider.fontFamily,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                items: const [
                  DropdownMenuItem(value: 'Roboto', child: Text('Roboto')),
                  DropdownMenuItem(value: 'Lato', child: Text('Lato')),
                  DropdownMenuItem(
                    value: 'Open Sans',
                    child: Text('Open Sans'),
                  ),
                  DropdownMenuItem(
                    value: 'Montserrat',
                    child: Text('Montserrat'),
                  ),
                  DropdownMenuItem(value: 'Poppins', child: Text('Poppins')),
                ],
                onChanged: (String? value) {
                  themeProvider.updateFontFamily(value!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
