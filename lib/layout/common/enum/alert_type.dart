import 'package:flutter/material.dart';

enum AlertType {
  success,
  error,
  warning,
}

extension AlertTypeExtension on AlertType {
  Widget icon({double size = 40}) {
    switch (this) {
      case AlertType.success:
        return const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.check_circle,
            color: Colors.blue,
          ),
        );
      case AlertType.error:
        return const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.error,
            color: Colors.red,
          ),
        );
      case AlertType.warning:
        return const SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.warning,
            color: Colors.orange,
          ),
        );
    }
  }
}
