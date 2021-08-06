import 'dart:math';

import 'package:ymmi_coonectv2/utils/user_secure_storage.dart';

class AuthService {
  Future<bool> login() async {
    await UserSecureStorage.getUsername();

    // Simulate a future for response after 2 second.
    return await Future<bool>.delayed(
        const Duration(
            seconds: 2
        ), () => Random().nextBool()
    );
  }

  // Logout
  Future<void> logout() async {
    // Simulate a future for response after 1 second.
    return await Future<void>.delayed(
        const Duration(
            seconds: 1
        )
    );
  }
}

class UserString {
  String user = 'null';
}