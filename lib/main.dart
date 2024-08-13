import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_login_flutter/pages/account_page.dart';
import 'package:supabase_login_flutter/pages/login_page.dart';
import 'package:supabase_login_flutter/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Supabase.initialize(
      url: 'https://fnkhpppsfwiopiyahyen.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZua2hwcHBzZndpb3BpeWFoeWVuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM1MjA3MDgsImV4cCI6MjAzOTA5NjcwOH0.ohaPhBsE0aV5vj7SJCZVWKAc7AzV5rzdnEhosDPpnMc',
    );
  } catch (e) {
    print('Supabase initialization failed: $e');
  }
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/account': (context) => AccountPage(),
      },
    );
  }
}
