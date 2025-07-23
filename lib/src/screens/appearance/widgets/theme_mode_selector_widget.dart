import 'package:flutter/material.dart';
import 'package:learning_flutter/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeModeSelectorWidget extends StatelessWidget {
  const ThemeModeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitle(),
        const SizedBox(height: 10.0),
        _buildDescription(),
        const SizedBox(height: 10.0),
        _buildThemeModeButtons(context),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Color Mode',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Choose if app\'s appearance should be light or dark, or follow system settings',
      style: TextStyle(fontSize: 14, height: 1.5),
    );
  }

  Widget _buildThemeModeButtons(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    final isLightMode = themeProvider.themeMode == ThemeMode.light;
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Row(
      children: <Widget>[
        _themeModeButton(
          context,
          text: 'Light mode',
          icon: Icons.light_mode,
          isSelected: isLightMode,
          onPressed: () => themeProvider.setThemeMode(ThemeMode.light),
        ),
        const SizedBox(width: 10),
        _themeModeButton(
          context,
          text: 'Dark mode',
          icon: Icons.dark_mode,
          isSelected: isDarkMode,
          onPressed: () => themeProvider.setThemeMode(ThemeMode.dark),
        ),
      ],
    );
  }

  Widget _themeModeButton(
    BuildContext context, {
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required bool isSelected,
  }) {
    return Expanded(
      child: TextButton.icon(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor:
              isSelected
                  ? Theme.of(context).primaryColorLight
                  : Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        icon: Icon(icon),
        label: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
