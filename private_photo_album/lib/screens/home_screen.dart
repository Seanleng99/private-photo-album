import 'package:flutter/material.dart';
import 'package:private_photo_album/services/biometric_authentication.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BiometricAuthentication();
  }
}