import 'package:flutter/material.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PORNEȘTE APLICAȚIA',
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.w500,
              )
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/items', (route) => true);
                },
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 10,
                ),
                color: Colors.red,
                textColor: Colors.white,
                child: Text(
                  'CLICK HERE',
                  style: TextStyle(
                    fontFamily: "Times New Roman",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
  );
  }
}

