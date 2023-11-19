import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restart_app/restart_app.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';

class TebUtil {
  static DateTime firstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime lastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  static String colorToHex(Color color) {
    if (color.value == 0) return '';
    return '#FF${color.value.toRadixString(16).substring(2, 8)}'.toUpperCase();
  }

  static Color hexStringToColor(String hexValue) {
    hexValue = hexValue.toUpperCase().replaceAll("#", "");
    if (hexValue.length == 6) {
      hexValue = "FF$hexValue";
    }
    if (int.tryParse(hexValue, radix: 16) == null) {
      return Colors.transparent;
    }

    return Color(int.parse(hexValue, radix: 16));
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
}
