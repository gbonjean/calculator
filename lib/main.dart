import 'package:calculator/calculator.dart';
import 'package:calculator/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: GoogleFonts.roboto().fontFamily,
        useMaterial3: true,
      ),
      home: const Calculator(title: 'Calculator'),
    );
  }
}

class Calculator extends StatelessWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Container(
          color: Theme.of(context).colorScheme.surfaceVariant,
          width: isPortrait
              ? SizeConfig.safeBlockHorizontal * 100
              : SizeConfig.safeBlockHorizontal * 40,
          height: isPortrait
              ? SizeConfig.safeBlockVertical * 70
              : SizeConfig.safeBlockVertical * 100,
          child: const CalculatorBody(),
        ),
      ),
    );
  }
}




