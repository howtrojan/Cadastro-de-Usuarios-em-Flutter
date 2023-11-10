import 'package:cadastrodeusuarios/models/user.dart';
import 'package:cadastrodeusuarios/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      _formData['id'] = user.id!;
      _formData['name'] = user.name!;
      _formData['email'] = user.email!;
      _formData['avatarUrl'] = user.avatarUrl!;
    } else {
      return;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;
    if (user != null) {
      _loadFormData(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de usuário'),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                final isValid = _form.currentState!.validate();

                if (isValid) {
                  _form.currentState?.save();
                  setState(() {
                    _isLoading = true;
                  });
                  await Provider.of<Users>(context, listen: false).put(
                    User(
                      id: _formData['id'] == null ? ' ' : _formData['id'],
                      name: _formData['name'] == null ? ' ' : _formData['name'],
                      email:
                          _formData['email'] == null ? ' ' : _formData['email'],
                      avatarUrl: _formData['avatarUrl'] == null
                          ? ' '
                          : _formData['avatarUrl'],
                    ),
                  );
                  Navigator.of(context).pop();
                }
                setState(() {
                  _isLoading = false;
                });
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(children: <Widget>[
                  TextFormField(
                    initialValue: _formData['name'],
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) => _formData['name'] = value!,
                  ),
                  TextFormField(
                    initialValue: _formData['email'],
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) => _formData['email'] = value!,
                  ),
                  TextFormField(
                    initialValue: _formData['AvatarUrl'],
                    decoration: InputDecoration(labelText: 'URL do Avatar'),
                    onSaved: (value) => _formData['avatarUrl'] = value!,
                  ),
                ]),
              ),
            ),
    );
  }
}
