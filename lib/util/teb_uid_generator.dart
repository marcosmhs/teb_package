// ignore: depend_on_referenced_packages
import 'package:nanoid/nanoid.dart';

class TebUidGenerator {
  static String get confirmId {
    return customAlphabet('abcdefghijklmnopqrstuwyxz', 5);
  }

  static String get accessLogUid {
    return 'accesslog-uid-${nanoid(18)}';
  }

  static String get invitationCode {
    return customAlphabet('1234567890ABCDEFGHIJKLMNOPQRSTUWYXZ', 8);
  }

  static String get firestoreUid {
    return 'firestore-uid-${nanoid(13)}';
  }
}
