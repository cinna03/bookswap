import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'auth/login_screen.dart';
import 'home/main_screen.dart';
import 'auth/email_verification_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.user == null) {
          return const LoginScreen();
        }
        
        if (!authProvider.user!.isEmailVerified) {
          return const EmailVerificationScreen();
        }
        
        return const MainScreen();
      },
    );
  }
}