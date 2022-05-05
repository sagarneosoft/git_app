import 'package:flutter/material.dart';
import 'package:github_user_listing_demo/features/user_listing/display/pages/listing_page.dart';
import 'package:github_user_listing_demo/main/main_page.dart';
import 'package:github_user_listing_demo/core/providers/navigation_provider.dart';
import 'package:github_user_listing_demo/features/user_listing/display/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> UserProvider()),
      ChangeNotifierProvider(create: (context)=> NavigationProvider()),

    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    ),
    );
  }
}
