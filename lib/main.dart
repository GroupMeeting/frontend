import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/settings_screen.dart'; // SettingsScreen import
import 'screens/RegistrationScreen.dart'; // RegistrationScreen import
import 'package:intl/date_symbol_data_local.dart'; // 날짜 로케일 초기화 함수
import 'screens/CreateDongariScreen.dart'; // CreateDongariScreen import
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/userModel.dart';
import 'models/dongari_model.dart';
import 'models/selectedContact.dart';
import 'screens/dbviewerScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // UserModel 어댑터 등록
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(DongariModelAdapter());
  Hive.registerAdapter(SelectedContactAdapter());

  // 'users'라는 이름의 박스 열기
  await Hive.openBox<UserModel>('users');
  await Hive.openBox<DongariModel>('dongari');
  // 날짜 로케일 초기화
  await initializeDateFormatting('ko_KR');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          surface: Colors.white, // 라이트 모드 배경색
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          surface: Colors.black, // 다크 모드 배경색
        ),
      ),
      // SettingsScreen 라우트 등록
      routes: {
        //'/': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/settings': (context) => SettingsScreen(),
        '/registration': (context) => RegistrationScreen(),
        '/createDongari': (context) => CreateDongariScreen(),
        '/dbviewer': (context) => DBViewerScreen(), // 추가
      },
     // 초기 화면은 로그인 화면으로 설정
      home: const LoginScreen(),
    );
  }
}