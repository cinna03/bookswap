import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.email,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 32),
            const Text(
              'Please verify your email',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Text(
                  'We sent a verification email to:\n${authProvider.user?.email}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .sendEmailVerification();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Verification email sent!')),
                );
              },
              child: const Text('Resend Email'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Refresh auth state to check verification
                Provider.of<AuthProvider>(context, listen: false);
              },
              child: const Text('I\'ve verified my email'),
            ),
          ],
        ),
      ),
    );
  }
}