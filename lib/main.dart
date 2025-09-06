import 'package:flutter/material.dart';
import 'package:roomy/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://tcoelajallrjoxxcellu.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRjb2VsYWphbGxyam94eGNlbGx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY5MDI0MDIsImV4cCI6MjA3MjQ3ODQwMn0.wkwORKwr2_aF9YFtTDAZ__hYLvnjx9nZ-Yii29F3AMM',
  );

  runApp(MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
