import 'package:FPay/routes/application.dart';
import 'package:FPay/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () async {
      //checking whether user is logged in using the token
      AuthService().isLoggedIn().then((_) {
        if (_)
          Application.router.navigateTo(context, '/home', clearStack: true);
        else
          Application.router.navigateTo(context, '/auth', clearStack: true);
      });
      //Application.router.navigateTo(context, '/auth');
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            children: <Widget>[
              Logo(), //sing stateless widget classses to show images
              Text(
                "Welcome to FPay",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                child: SpinKitDoubleBounce(
                  color: Colors.lightBlueAccent,

                ),
              )
              
            ],
          ),
        ),
      );
  }
}

//insert images as statlessss widget
class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('lib/images/logo.png');
    Image image = Image(
      image: assetImage,
      width: 100,
      height: 100,
    );
    return Container(
      child: image,
      margin: EdgeInsets.only(top: 200),
    );
  }
}