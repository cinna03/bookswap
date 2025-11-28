import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                subtitle: Text(authProvider.user?.email ?? ''),
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Push Notifications'),
                subtitle: const Text('Receive notifications for new messages'),
                value: true,
                onChanged: (value) {
                  // TODO: Implement notification toggle
                },
              ),
              SwitchListTile(
                title: const Text('Email Notifications'),
                subtitle: const Text('Receive email updates'),
                value: false,
                onChanged: (value) {
                  // TODO: Implement email toggle
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  authProvider.signOut();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}