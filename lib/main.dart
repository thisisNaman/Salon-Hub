import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/routes.dart';
import 'package:salon_hub/screens/home/home_screen.dart';
import 'package:salon_hub/screens/sign_in/sign_in_screen.dart';
import 'package:salon_hub/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:salon_hub/services/authentication_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dot_env.dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isConnected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.connected) {
        setState(() {
          isConnected = true;
        });
      } else {
        setState(() {
          isConnected = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null),
      ],
      child: isConnected == true
          ? MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'The Salon Hub',
              theme: theme(),
              home: AuthenticationWrapper(),
              routes: routes,
            )
          : MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'The Salon Hub',
              theme: theme(),
              home: const Scaffold(
                body: Center(
                    child: Icon(
                  Icons.wifi_off_sharp,
                  color: kPrimaryColor,
                  size: 40.0,
                )),
              ),
            ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User?>();

    if (firebaseuser != null) {
      return HomeScreen();
    } else
      return SignInScreen();
  }
}
