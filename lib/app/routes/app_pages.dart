import 'package:get/get.dart';
import '../modules/auth_binding.dart';
import '../modules/create_task_screen.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_screen.dart';
import '../modules/login_page.dart';
import '../modules/register_page.dart'; // Import halaman Register

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = AppRoutes.LOGIN; // Set rute awal ke LOGIN

  static final routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(), // Bind untuk AuthController
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterPage(),
      binding: AuthBinding(), // Bind untuk AuthController
    ),
    GetPage(
      name: AppRoutes.HOMESCREEN,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.CREATE_TASK,
      page: () => CreateTaskScreen(isEdit: false),
    ),
    
  ];
}
