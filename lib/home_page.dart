import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/camera_page.dart';
import 'package:untitled1/locations.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img.png'),
                fit: BoxFit.cover,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 150.0),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome to AGAR",
                        style: TextStyle(
                          fontSize: 26.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "AI tour guide",
                        style: TextStyle(
                          fontSize: 26.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                    'Press Start to guide',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                    )
                ),
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey[600],),
                    onPressed: ()  {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseLocation(),
                        ),
                      );
                    },
                    child: const Text(
                        'Start',
                        style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                      )
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
    );
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              Text(
                "Welcome to AGAR. AI tour guide",
                style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.red,

                ),
              ),

            ],
          )
      )

    );
  }
}
