import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/views/employee_list_screen/employee_list_screen.dart';

import 'app_theme.dart';
import 'controllers/bloc/employee_bloc/employee_bloc.dart';
import 'controllers/repository/database_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(),
      child: MaterialApp(
        title: 'To Do',
        debugShowCheckedModeBanner: false,
        home: const EmployeeListScreen(),
        onGenerateRoute: AppNavigator.onGenerateRoute,
        scaffoldMessengerKey: AppNavigator.scaffoldMessengerKey,
        navigatorKey: AppNavigator.navigatorKey,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.blueDark),
        ),
      ),
    );
  }
}
