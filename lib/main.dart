import 'package:app_cripto/Repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'meu_aplicativo.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritasRepository(),
      child: const MeuAplicativo(),
    ),
  );
}
