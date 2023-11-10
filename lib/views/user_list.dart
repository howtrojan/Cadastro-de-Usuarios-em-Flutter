import 'package:cadastrodeusuarios/provider/users.dart';
import 'package:cadastrodeusuarios/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:cadastrodeusuarios/components/user_tile.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (ctx, i) => UserTile(users.byIndex(i))),
    );
  }
}
