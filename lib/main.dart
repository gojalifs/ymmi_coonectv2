import 'package:flutter/material.dart';
import 'package:ymmi_coonectv2/page/home_page.dart';
import 'package:ymmi_coonectv2/page/login_page.dart';
import 'package:ymmi_coonectv2/routes.dart';
import 'package:ymmi_coonectv2/utils/user_secure_storage.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'YMMI Connect';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: const MyStatefulWidget(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: routes,
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder(
        future: user(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Splash(),
              routes: routes,
            );
          } else {
            if (snapshot.hasData) {
              return mainAppBuilder(const HomePage());
            } else {
              return mainAppBuilder(const LoginPage());
            }
          }
        },
      ),
    );
  }

  Future user() async {
    final Future<String?> _user = UserSecureStorage.getUsername();
    return _user;
  }

  MaterialApp mainAppBuilder(Widget widget) {
    return MaterialApp(
      home: widget,
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'ubuntu',
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(const Duration(
            seconds: 10,
          )),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ],
            );
          },

          /*


           */
        ),
      ),
    );
  }
}

/* void main() async {
  runApp(MyApp());

//   // Set default home.
//   Widget _defaultHome = new LoginPage();
//
//   // Get result of the login function.
//   AuthService appAuth = AuthService();
//   bool _result = await appAuth.login();
//   if (_result) {
//     _defaultHome = HomePage();
//   }
//
//   // Run app!
//   runApp(MaterialApp(
//     title: 'App',
//     home: LoginPage(),
//     routes: <String, WidgetBuilder>{
//       // Set routes for using the Navigator.
//       '/home': (BuildContext context) => HomePage(),
//       '/login': (BuildContext context) => LoginPage()
//     },
//   ));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // var user = UserSecureStorage.getUsername().toString();

  // Widget _defaultHome = LoginPage();
  // This widget is the root of your application.

  final Future _user = UserSecureStorage.getUsername();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _user,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return const MaterialApp(
            home: HomePage(),
          );
        } else {
          return MaterialApp(
            title: 'YMMI Connect',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.deepPurple,
            ),
            home: const LoginPage(),
            routes: routes,
          );
        }
        // else {
        //   children = const <Widget>[
        //     SizedBox(
        //       child: CircularProgressIndicator(),
        //       width: 60,
        //       height: 60,
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(top: 16),
        //       child: Text(
        //         'Awaiting result...',
        //         textDirection: TextDirection.ltr,
        //       ),
        //     )
        //   ];
        // }
        // return Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: children,
        //   ),
        // );
      },
    );
    // return MaterialApp(
    //   title: 'YMMI Connect',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.deepPurple,
    //   ),
    //   home: LoginPage(),
    //   routes: routes,
    // );
  }
}

 */
