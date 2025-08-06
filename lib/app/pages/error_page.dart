import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required String errorMessage,
    required StackTrace stack,
  }) : _message = errorMessage,
       _stack = stack;

  final String _message;
  final StackTrace _stack;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello Pokemon",
      home: Scaffold(body: Center(child: Text(_message))),
    );
  }
}
