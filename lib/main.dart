import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_hub/routes.dart';
import 'package:salon_hub/screens/home/home_screen.dart';
import 'package:salon_hub/screens/sign_in/sign_in_screen.dart';
import 'package:salon_hub/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:salon_hub/services/authentication_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dot_env.dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Salon Hub',
          theme: theme(),
          home: AuthenticationWrapper(),
          routes: routes,
        ));
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
