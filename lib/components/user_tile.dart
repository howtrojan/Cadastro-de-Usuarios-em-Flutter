import 'package:cadastrodeusuarios/provider/users.dart';
import 'package:cadastrodeusuarios/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:cadastrodeusuarios/models/user.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User? user;

  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = user!.avatarUrl!.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(
            backgroundImage: NetworkImage(user!.avatarUrl!),
          );
    return ListTile(
        leading: avatar,
        title: Text(user!.name!),
        subtitle: Text(user!.email!),
        trailing: Container(
          width: 100,
          child: Row(children: <Widget>[
            IconButton(
              color: Colors.orange,
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
            ),
            IconButton(
              color: Colors.red,
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Excluir Usuário'),
                          content: Text('Tem certeza?'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Não'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<Users>(context, listen: false)
                                    .remove(user);
                                Navigator.of(context).pop();
                              },
                              child: Text('Sim'),
                            )
                          ],
                        ));
              },
            )
          ]),
        ));
  }
}
