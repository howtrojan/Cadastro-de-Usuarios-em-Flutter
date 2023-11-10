import 'package:cadastrodeusuarios/provider/users.dart';
import 'package:cadastrodeusuarios/routes/app_routes.dart';
import 'package:cadastrodeusuarios/views/user_form.dart';
import 'package:cadastrodeusuarios/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
            AppRoutes.HOME: (_) => UserList(),
            AppRoutes.USER_FORM: (_) => UserForm()
          }),
    );
  }
}
