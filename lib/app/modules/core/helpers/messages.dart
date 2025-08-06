import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

final class Messages {
  static void showError(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: message),
      persistent: false,
      displayDuration: const Duration(milliseconds: 1000),
    );
  }

  static void showInfo(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(message: message),
      persistent: false,
      displayDuration: const Duration(milliseconds: 1000),
    );
  }

  static void showSuccess(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: message),
      displayDuration: const Duration(milliseconds: 1000),
      persistent: false,
    );
  }
}

mixin MessageControllerMixin {
  final ValueNotifier<String?> errorMessageNotifier = ValueNotifier<String?>(
    null,
  );
  String? get errorMessage => errorMessageNotifier.value;

  final ValueNotifier<String?> infoMessageNotifier = ValueNotifier<String?>(
    null,
  );
  String? get infoMessage => infoMessageNotifier.value;

  final ValueNotifier<String?> successMessageNotifier = ValueNotifier<String?>(
    null,
  );
  String? get successMessage => successMessageNotifier.value;

  void clearError() => errorMessageNotifier.value = null;
  void clearInfo() => infoMessageNotifier.value = null;
  void clearSuccess() => successMessageNotifier.value = null;

  void showError(String message) {
    clearError();
    errorMessageNotifier.value = message;
  }

  void showInfo(String message) {
    clearInfo();
    infoMessageNotifier.value = message;
  }

  void showSuccess(String message) {
    clearSuccess();
    successMessageNotifier.value = message;
  }

  void clearAllMessages() {
    clearError();
    clearInfo();
    clearSuccess();
  }

  void disposeMessages() {
    errorMessageNotifier.dispose();
    infoMessageNotifier.dispose();
    successMessageNotifier.dispose();
  }
}

mixin MessageViewMixin<T extends StatefulWidget> on State<T> {
  void messageListener(MessageControllerMixin state) {
    state.errorMessageNotifier.addListener(() {
      final errorMessage = state.errorMessageNotifier.value;
      if (mounted && errorMessage != null) {
        Messages.showError(errorMessage, context);
      }
    });
    state.infoMessageNotifier.addListener(() {
      final infoMessage = state.infoMessageNotifier.value;
      if (mounted && infoMessage != null) {
        Messages.showInfo(infoMessage, context);
      }
    });
    state.successMessageNotifier.addListener(() {
      final successMessage = state.successMessageNotifier.value;
      if (mounted && successMessage != null) {
        Messages.showSuccess(successMessage, context);
      }
    });
  }
}
