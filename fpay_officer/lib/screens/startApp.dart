import "package:flutter/material.dart";

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Online fine payment mobile appliction",
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Logo(),
              Text(
                "Welcome to FPay",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 30,
                ),
              ),
              const RaisedButton(
                onPressed: null,
                child: Text('Disabled Button', style: TextStyle(fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
