import 'package:flutter/material.dart';
import 'package:learning_flutter/src/themes/theme_fonts.dart';
import 'package:learning_flutter/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeFontSelectorWidget extends StatelessWidget {
  const ThemeFontSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitle(),
        const SizedBox(height: 10),
        _buildDescription(),
        const SizedBox(height: 10),
        _buildFontDropdownMenu(context),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Custom Font',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Select custom font for your workspace',
      style: TextStyle(fontSize: 14, height: 1.5),
    );
  }

  Widget _buildFontDropdownMenu(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<FontFamily>(
          value: themeProvider.fontFamily,
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          items: const [
            DropdownMenuItem(value: FontFamily.roboto, child: Text('Roboto')),
            DropdownMenuItem(value: FontFamily.lato, child: Text('Lato')),
            DropdownMenuItem(
              value: FontFamily.openSans,
              child: Text('Open Sans'),
            ),
            DropdownMenuItem(
              value: FontFamily.montserrat,
              child: Text('Montserrat'),
            ),
            DropdownMenuItem(value: FontFamily.poppins, child: Text('Poppins')),
          ],
          onChanged: (FontFamily? selectedFont) {
            if (selectedFont != null)
              themeProvider.updateFontFamily(selectedFont);
          },
        ),
      ),
    );
  }
}
