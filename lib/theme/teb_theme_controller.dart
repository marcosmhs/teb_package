import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:teb_package/log/debug_log/teb_debug_log.dart';
import 'package:teb_package/teb_package.dart';

class TebThemeController {
  final String? lightThemeAssetPath;
  final String? darkThemeAssetPath;
  final bool useMaterial3;
  final bool useDebugLog;
  final FirebaseFirestore? fireStoreInstance;

  late ThemeData? _lightThemeData;
  late ThemeData? _darkThemeData;

  ThemeData get lightThemeData => _lightThemeData ?? ThemeData.light(useMaterial3: useMaterial3);
  ThemeData get darkThemeData => _darkThemeData ?? ThemeData.dark(useMaterial3: useMaterial3);

  /// TebThemeController (Compatível apenas com arquivos json criados via https://appainter.dev/)
  ///
  /// **lightThemeAssetPath** e **lightThemeAssetPath** devem ser preenchidos com o caminho
  /// determinado no arquivo pubspec.yaml. Caso não tenhoa o tema claro ou escuro
  /// não devem ser preenchidos.
  ///
  /// **useMaterial3**
  /// Quando lightThemeAssetPath e/ou lightThemeAssetPath não são preenchidos esta
  /// variável indica qual o estilo dos temas padrão que serão gerados
  ///
  /// **useDebugLog**
  /// Indica que qualquer mensagem também será salva em formato de log no Firebase
  /// neste caso a variável **fireStoreInstance** deve ser preenchida
  TebThemeController({
    this.lightThemeAssetPath,
    this.darkThemeAssetPath,
    this.useMaterial3 = true,
    this.useDebugLog = true,
    this.fireStoreInstance,
  });

  /// TebThemeController.loadThemeData
  ///
  /// Método do tipo future que responsável por fazer a leitura dos arquivos json
  /// informados na criação da classe
  Future<TebCustomReturn> get loadThemeData async {
    try {
      if ((lightThemeAssetPath ?? '').isNotEmpty) {
        var lightThemeStr = await rootBundle.loadString(lightThemeAssetPath!);
        var lightThemeJson = json.decode(lightThemeStr);
        _lightThemeData = ThemeDecoder.decodeThemeData(
          lightThemeJson,
          validate: true,
        );
        if (_lightThemeData == null) {
          _lightThemeData = ThemeData.light(useMaterial3: useMaterial3);
          if (useDebugLog && fireStoreInstance != null) {
            TebDebugLog(
              fireStoreInstance: fireStoreInstance!,
              group: 'TebThemeController',
              message: 'Erro ao ler o ${lightThemeAssetPath!}',
            );
          }
          return TebCustomReturn.error('Erro ao ler o ${lightThemeAssetPath!}');
        }
      }

      if ((darkThemeAssetPath ?? '').isNotEmpty) {
        var darkThemeStr = await rootBundle.loadString(darkThemeAssetPath!);
        var darkThemeJson = json.decode(darkThemeStr);
        _darkThemeData = ThemeDecoder.decodeThemeData(
          darkThemeJson,
          validate: true,
        );
        if (_darkThemeData == null) {
          _darkThemeData = ThemeData.dark(useMaterial3: useMaterial3);
          if (useDebugLog && fireStoreInstance != null) {
            TebDebugLog(
              fireStoreInstance: fireStoreInstance!,
              group: 'TebThemeController',
              message: 'Erro ao ler o ${darkThemeAssetPath!}',
            );
          }
          return TebCustomReturn.error('Erro ao ler o ${darkThemeAssetPath!}');
        }
      }

      return TebCustomReturn.sucess;
    } catch (e) {
      if (useDebugLog && fireStoreInstance != null) {
        TebDebugLog(
          fireStoreInstance: fireStoreInstance!,
          group: 'TebThemeController',
          message: e.toString(),
        );
      }
      return TebCustomReturn.error(e.toString());
    }
  }
}
