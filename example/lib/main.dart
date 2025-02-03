import 'package:flutter/material.dart';
import 'package:xdialog/xdialog.dart';

void main() => runApp(const XDialogExampleApp());

class XDialogExampleApp extends StatelessWidget {
  const XDialogExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XDialog Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const XDialogExampleScreen(),
    );
  }
}

class XDialogExampleScreen extends StatelessWidget {
  const XDialogExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('XDialog Examples')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildExampleButton(
              context,
              'Basic Dialog',
              Colors.blue,
              () => XDialog.show(
                context: context,
                title: 'Welcome!',
                message: 'This is a basic XDialog example',
              ),
            ),
            _buildExampleButton(
              context,
              'Custom Icon',
              Colors.amber,
              () => XDialog.show(
                context: context,
                title: 'Warning',
                message: 'Critical system alert',
                icon: const Icon(Icons.warning, size: 50, color: Colors.amber),
                positiveButtonColor: Colors.amber,
              ),
            ),
            _buildExampleButton(
              context,
              'Multiple Buttons',
              Colors.blue,
              () => XDialog.show(
                context: context,
                title: 'Confirm Action',
                message: 'Please select an option:',
                positiveButtonText: 'Accept',
                negativeButtonText: 'Decline',
                neutralButtonText: 'More Info',
                neutralButtonColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleButton(
      BuildContext context, String text, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
