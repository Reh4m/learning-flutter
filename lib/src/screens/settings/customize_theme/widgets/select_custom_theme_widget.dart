import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/theme_colors.dart';
import 'package:learning_flutter/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class SelectCustomThemeWidget extends StatefulWidget {
  const SelectCustomThemeWidget({super.key});

  @override
  State<SelectCustomThemeWidget> createState() =>
      _SelectCustomThemeWidgetState();
}

class _SelectCustomThemeWidgetState extends State<SelectCustomThemeWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitle(),
        const SizedBox(height: 10),
        _buildDescription(),
        const SizedBox(height: 10),
        _buildThemeColorChips(themeProvider),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Select Custom Theme',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Choose a custom theme for the app. You can select from a variety of themes to personalize your experience.',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5),
    );
  }

  Widget _buildThemeColorChips(ThemeProvider themeProvider) {
    return Wrap(
      spacing: 10,
      children:
          ThemeColors.themeColors.entries.map((entry) {
            final themeColor = entry.key;
            final customTheme = entry.value;

            return _actionChip(themeProvider, themeColor, customTheme);
          }).toList(),
    );
  }

  Widget _actionChip(
    ThemeProvider themeProvider,
    ThemeColor themeColor,
    CustomTheme customTheme,
  ) {
    final isSelected = themeProvider.themeColor == themeColor;

    return ActionChip(
      onPressed: () => themeProvider.updateThemeColor(themeColor),
      backgroundColor:
          isSelected
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).colorScheme.surface,
      avatar: CircleAvatar(backgroundColor: customTheme.primaryColor),
      label: Text(
        customTheme.colorName,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      side: BorderSide.none,
    );
  }
}
