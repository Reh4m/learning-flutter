import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/light_theme.dart';
import 'package:learning_flutter/src/themes/theme_colors.dart';
import 'package:learning_flutter/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeColorSelectorWidget extends StatelessWidget {
  const ThemeColorSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitle(),
        const SizedBox(height: 10.0),
        _buildDescription(),
        const SizedBox(height: 10.0),
        _buildThemeColorOptions(context),
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
      style: TextStyle(fontSize: 14, height: 1.5),
    );
  }

  Widget _buildThemeColorOptions(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    return Wrap(
      spacing: 10,
      children:
          ThemeColors.themeColors.entries.map((entry) {
            final themeColor = entry.key;
            final customTheme = entry.value;

            return _themeColorChip(
              context,
              customTheme,
              isSelected: themeProvider.themeColor == themeColor,
              onPressed: () => themeProvider.setThemeColor(themeColor),
            );
          }).toList(),
    );
  }

  Widget _themeColorChip(
    BuildContext context,
    CustomTheme customTheme, {
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ActionChip(
      onPressed: onPressed,
      backgroundColor:
          isSelected
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).colorScheme.surface,
      avatar: CircleAvatar(backgroundColor: customTheme.primaryColor),
      label: Text(
        customTheme.colorName,
        style: TextStyle(
          color: isSelected ? LightTheme.textPrimary : null,
          fontSize: 14,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      side: BorderSide.none,
    );
  }
}
