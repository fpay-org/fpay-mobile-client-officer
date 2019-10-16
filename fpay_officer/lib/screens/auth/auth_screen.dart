import 'package:FPay/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "Email"),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(hintText: "Password"),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    child: Text("Login"),
                    onPressed: () => _handleLogin(_email, _password),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _handleLogin(String email, String password) {
    AuthService().login(email, password);
  }
}
