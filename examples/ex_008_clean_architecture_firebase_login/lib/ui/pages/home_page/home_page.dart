import 'package:clean_architecture_firebase_login/service/user_extension.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              //get UserService reactiveModel and call setState to signOut,
              user.setState((s) => s.signOut());
            },
          )
        ],
      ),
      body:
          Center(child: Text('Welcome ${user.state.email ?? user.state.uid}!')),
    );
  }
}
