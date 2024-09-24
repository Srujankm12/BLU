import 'package:blu/features/auth/bloc/auth_bloc.dart';
import 'package:blu/features/home/bloc/homepage_bloc.dart';
import 'package:blu/features/home/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'features/Auth/pages/login_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDirectory.path);
  final box = await Hive.openBox('authtoken');
  runApp(MyApp(token: box.get('token')));
  await box.close();
}

class MyApp extends StatelessWidget {
  final dynamic token;
  const MyApp({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BLU',
      theme: ThemeData(
      ),
      
      home: (token != null)
          ? BlocProvider(
              create: (context) => HomepageBloc(),
              child:const HomePage(),
            )
          : BlocProvider(
              create: (context) => AuthBloc(),
              child: LoginPage(),
            ),
    );
  }
}
