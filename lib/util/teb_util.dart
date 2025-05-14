import 'package:encrypt/encrypt.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restart_app/restart_app.dart';
import 'package:flutter/material.dart' as flutter;

import 'dart:convert';
import 'package:crypto/crypto.dart';

enum TextWidth { tw2, tw4, tw6, tw8, tw10, tw12, tw14, tw16, tw18, tw20 }

class TebUtil {
  static DateTime firstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime lastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  static String colorToHex(flutter.Color color) {
    if (color.toARGB32() == 0) return '';
    return '#FF${color.toARGB32().toRadixString(16).substring(2, 8)}'.toUpperCase();
  }

  static flutter.Color hexStringToColor(String hexValue) {
    hexValue = hexValue.toUpperCase().replaceAll("#", "");
    if (hexValue.length == 6) {
      hexValue = "FF$hexValue";
    }
    if (int.tryParse(hexValue, radix: 16) == null) {
      return flutter.Colors.transparent;
    }

    return flutter.Color(int.parse(hexValue, radix: 16));
  }

  static int countSundays(DateTime start, DateTime end) {
    int count = 0;
    DateTime currentDate = start;

    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      if (currentDate.weekday == DateTime.sunday) {
        count++;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return count;
  }

  static List<DateTime> getSundayList(DateTime start, DateTime end) {
    DateTime currentDate = start;

    List<DateTime> sundayCount = [];

    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      if (currentDate.weekday == DateTime.sunday) sundayCount.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return sundayCount;
  }

  static void restartApplication() {
    Restart.restartApp();
  }

  static String dateTimeFormat({required DateTime date, String mask = 'dd/MM/yyyy'}) {
    return DateFormat(mask).format(date);
  }

  static String formatedCurrencyValue({required double value, bool showSignal = false}) {
    final currency = NumberFormat.currency(
      locale: 'pt-BR',
      customPattern: '#,### \u00a4',
      symbol: '',
      decimalDigits: 2,
    );

    var formatedValue = "R\$ ${currency.format(value)}";

    if (value < 0) {
      formatedValue = '- $formatedValue';
    }

    return formatedValue;
  }

  static PackageInfo get packageInfo {
    return PackageInfo(
      appName: '',
      packageName: '',
      version: '',
      buildNumber: '',
      buildSignature: '',
      installerStore: '',
    );
  }

  static Future<PackageInfo> get version {
    return PackageInfo.fromPlatform();
  }

  static String encrypt(String value) {
    var key = utf8.encode('58d2d4447787df6bf0686d127ab7752a1999ad98cbac0c0778364e7f7c977200');
    var bytes = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }

  String encryptText(String text, String key) {
    final encrypterKey = Key.fromUtf8(key.padRight(32, '0').substring(0, 32));
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(encrypterKey));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  String decryptText(String encryptedText, String key) {
    final encrypterKey = Key.fromUtf8(key.padRight(32, '0').substring(0, 32));
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(encrypterKey));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }

  static double textWidthCalculation(TextWidth textWidth) {
    double result = 0;
    result = switch (textWidth) {
      TextWidth.tw2 => 100,
      TextWidth.tw4 => 150,
      TextWidth.tw6 => 200,
      TextWidth.tw8 => 250,
      TextWidth.tw10 => 300,
      TextWidth.tw12 => 350,
      TextWidth.tw14 => 400,
      TextWidth.tw16 => 450,
      TextWidth.tw18 => 500,
      TextWidth.tw20 => 600,
    };
    return result;
  }

  static bool isDateEqual(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
