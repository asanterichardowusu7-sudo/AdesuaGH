import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/notes_list_screen.dart';
import 'firebase_options.dart'; // generated or filled

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AdesuaApp());
}

class AdesuaApp extends StatelessWidget {
  const AdesuaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'AdesuaGH',
        theme: ThemeData(
          primarySwatch: Colors.teal,fontFamily: 'NotoSans'
        ),
        home: const Root(),
        locale: const Locale('en', 'US'),
        supportedLocales: const [
        Locale('en', 'US'),
        ],
      ),
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return StreamBuilder(
      stream: auth.userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) {
          return const NotesListScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
