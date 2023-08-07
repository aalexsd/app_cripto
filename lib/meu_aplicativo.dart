import 'package:flutter/material.dart';

import 'Pages/home_page.dart';
import 'Pages/moedas_page.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppCripto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        )
      ),
      home: const HomePage(),
    );
  }
}