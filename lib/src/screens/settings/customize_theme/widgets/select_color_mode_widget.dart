import 'package:flutter/material.dart';
import 'package:learning_flutter/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class SelectColorModeWidget extends StatefulWidget {
  const SelectColorModeWidget({super.key});

  @override
  State<SelectColorModeWidget> createState() => _SelectColorModeWidgetState();
}

class _SelectColorModeWidgetState extends State<SelectColorModeWidget> {
  void _switchColorMode(
    ThemeProvider themeProvider,
    ThemeMode targetMode,
  ) async {
    if (themeProvider.themeMode != targetMode) {
      await themeProvider.updateThemeMode(targetMode);
    }
  }

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
        _buildColorModeButtons(themeProvider),
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
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5),
    );
  }

  Widget _buildColorModeButtons(ThemeProvider themeProvider) {
    return Row(
      children: <Widget>[
        _colorModeButton(
          text: 'Light mode',
          icon: Icons.light_mode,
          isSelected: themeProvider.themeMode == ThemeMode.light,
          onPressed: () => _switchColorMode(themeProvider, ThemeMode.light),
        ),
        const SizedBox(width: 10),
        _colorModeButton(
          text: 'Dark mode',
          icon: Icons.dark_mode,
          isSelected: themeProvider.themeMode == ThemeMode.dark,
          onPressed: () => _switchColorMode(themeProvider, ThemeMode.dark),
        ),
      ],
    );
  }

  Widget _colorModeButton({
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
