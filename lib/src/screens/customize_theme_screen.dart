import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
                  _buildSelectFont(),
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
        ],
      ),
    );
  }

  Widget _buildColorPicker() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Custom themes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Text(
            'Set your own app theme by selecting primary and secondary colors',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectFont() {
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
        ],
      ),
    );
  }
}
