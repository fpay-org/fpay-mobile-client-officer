import 'package:FPay/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main(){

  test('Empty id returns error string',(){
    var result = OfficerIDValidator.validate('');
    expect(result, 'Id number cannot be empty');
  });

  test('id without exactly 6 digits returns error string',(){
    var result = OfficerIDValidator.validate('789');
    expect(result, "Not a valid Id number");
  });

  test('Empty password returns error string',(){
    var result = PasswordValidator.validate('');
    expect(result, 'Password cannot be empty');
  });

  test('Non empty password returns null',(){
    var result = PasswordValidator.validate('password');
    expect(result, 'null');
  });

}