import 'package:flutter/material.dart';
import 'package:hello_pokemon/app/modules/core/widgets/custom_loader.dart';

final class Loader {
  // ignore: avoid_init_to_null
  static OverlayEntry? _overlayEntry = null;

  static bool _isShowing = false;

  static void showLoader(bool? showOrRemoveLoader, BuildContext context) {
    final overlay = Overlay.of(context);

    switch (showOrRemoveLoader) {
      case true:
        if (!_isShowing) {
          _overlayEntry = OverlayEntry(
            builder: (_) => const CustomLoader(),
            maintainState: false,
          );
          overlay.insert(_overlayEntry!);
          _isShowing = true;
        }
        break;
      case false:
        if (_isShowing) {
          _overlayEntry?.remove();
          _isShowing = false;
        }
        break;
      case null:
        null;
    }
  }

  static void disposeLoader() {
    if (_isShowing) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isShowing = false;
    }
  }
}

mixin LoaderControllerMixin {
  final ValueNotifier<bool?> showLoaderNotifier = ValueNotifier<bool?>(null);
  bool? get showLoader => showLoaderNotifier.value;

  void _clearLoader() => showLoaderNotifier.value = null;

  void loader(bool showLoader) {
    _clearLoader();
    showLoaderNotifier.value = showLoader;
  }

  void disposeLoader() {
    showLoaderNotifier.dispose();
  }
}

mixin LoaderViewMixin<T extends StatefulWidget> on State<T> {
  void loaderListener(LoaderControllerMixin state) {
    state.showLoaderNotifier.addListener(() {
      final showLoader = state.showLoaderNotifier.value;
      if (mounted) {
        Loader.showLoader(showLoader, context);
      }
    });
  }
}
