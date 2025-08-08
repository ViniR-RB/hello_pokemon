import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required String errorMessage,
    required StackTrace stack,
    required VoidCallback onRestart,
  }) : _message = errorMessage,
       _stack = stack,
       _onRestart = onRestart;

  final String _message;
  final StackTrace _stack;
  final VoidCallback _onRestart;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Ops! Algo deu errado',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => _onRestart(),
                  child: const Text('Reiniciar App'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
