import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_hub/components/default_button.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/helper/snack_bar.dart';
import 'package:salon_hub/routes.dart';
import 'package:salon_hub/screens/home/home_screen.dart';
import 'package:salon_hub/screens/sign_in/sign_in_screen.dart';
import 'package:salon_hub/size_config.dart';
import 'package:salon_hub/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:salon_hub/services/authentication_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:in_app_update/in_app_update.dart';

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
  AppUpdateInfo? _updateInfo;

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnackbar(context, e.toString());
    });
  }

  @override
  void initState() {
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
    checkForUpdate();
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
      child: isConnected == true &&
              _updateInfo?.updateAvailability ==
                  UpdateAvailability.updateNotAvailable
          ? MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'The Salon Hub',
              theme: theme(),
              home: const AuthenticationWrapper(),
              routes: routes,
            )
          : _updateInfo?.updateAvailability ==
                  UpdateAvailability.updateAvailable
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'The Salon Hub',
                  theme: theme(),
                  home: Scaffold(
                    body: Center(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(20.0),
                        height: 200,
                        width: 500,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'New Update available!',
                                style: TextStyle(
                                    overflow: TextOverflow.fade,
                                    fontSize: 20,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Update for latest discount offers!!',
                                style: TextStyle(
                                    overflow: TextOverflow.fade,
                                    fontSize: 20,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                child: const Text('Perform immediate update'),
                                onPressed: _updateInfo?.updateAvailability ==
                                        UpdateAvailability.updateAvailable
                                    ? () {
                                        InAppUpdate.performImmediateUpdate()
                                            .catchError((e) => showSnackbar(
                                                context, e.toString()));
                                      }
                                    : null,
                              ),
                            ]),
                      ),
                    ),
                  ),
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
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User?>();

    if (firebaseuser != null) {
      return const HomeScreen();
    } else {
      return SignInScreen();
    }
  }
}
