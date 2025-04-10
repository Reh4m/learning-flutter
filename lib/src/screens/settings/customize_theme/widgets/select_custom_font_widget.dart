import 'package:flutter/material.dart';
import 'package:learning_flutter/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class SelectCustomFontWidget extends StatefulWidget {
  const SelectCustomFontWidget({super.key});

  @override
  State<SelectCustomFontWidget> createState() => _SelectCustomFontWidgetState();
}

class _SelectCustomFontWidgetState extends State<SelectCustomFontWidget> {
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
        _buildFontDropdownContainer(themeProvider),
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
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5),
    );
  }

  Widget _buildFontDropdown(ThemeProvider themeProvider) {
    return DropdownButton<String>(
      value: themeProvider.fontFamily,
      isExpanded: true,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      items: const [
        DropdownMenuItem(value: 'Roboto', child: Text('Roboto')),
        DropdownMenuItem(value: 'Lato', child: Text('Lato')),
        DropdownMenuItem(value: 'Open Sans', child: Text('Open Sans')),
        DropdownMenuItem(value: 'Montserrat', child: Text('Montserrat')),
        DropdownMenuItem(value: 'Poppins', child: Text('Poppins')),
      ],
      onChanged: (String? value) {
        themeProvider.updateFontFamily(value!);
      },
    );
  }

  Widget _buildFontDropdownContainer(ThemeProvider themeProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: _buildFontDropdown(themeProvider),
      ),
    );
  }
}
