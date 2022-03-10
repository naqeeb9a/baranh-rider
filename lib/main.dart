import 'package:animations/animations.dart';
import 'package:baranh_rider/utils/config.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/tab_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M-Track',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CustomColors.primaryColor,
        textTheme: GoogleFonts.baloo2TextTheme(
          Theme.of(context).textTheme,
        ),
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal),
          },
        ),
      ),
      home: const CustomTabBar(),
    );
  }
}
