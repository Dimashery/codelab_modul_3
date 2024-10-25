import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth_controller.dart';

class HomeView extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authController.logout(); // Panggil fungsi logout ketika tombol ditekan.
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to Home!'), // Konten di Home
      ),
    );
  }
}
