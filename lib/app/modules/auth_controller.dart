import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home/views/home_view.dart';
import 'login_page.dart';


class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  // Fungsi untuk registrasi pengguna
  Future<void> registerUser(String email, String password) async {
    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar('Error', 'Please enter a valid email',
          backgroundColor: Colors.red);
      return;
    }
    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters',
          backgroundColor: Colors.red);
      return;
    }

    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);
      Get.offAll(LoginPage()); // Beralih ke halaman Login setelah registrasi berhasil
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk login pengguna
  Future<void> loginUser(String email, String password) async {
    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar('Error', 'Please enter a valid email',
          backgroundColor: Colors.red);
      return;
    }
    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters',
          backgroundColor: Colors.red);
      return;
    }

    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green);
      Get.offAll(HomeView()); // Navigasi ke HomeView setelah login berhasil
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    await _auth.signOut();
    Get.offAll(LoginPage()); // Menghapus semua halaman dari stack dan kembali ke halaman login.
  }
}
