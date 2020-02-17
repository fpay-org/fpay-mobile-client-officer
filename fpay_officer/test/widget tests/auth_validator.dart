import 'package:FPay/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child
    );
  }

  testWidgets('email or password is empty does not sign in', (WidgetTester tester) async {
    AuthScreen authScreen = AuthScreen();
    
  });
}

