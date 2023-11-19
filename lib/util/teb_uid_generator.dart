import 'package:nanoid/nanoid.dart';

class TebUidGenerator {
  static String get confirmId => customAlphabet('abcdefghijklmnopqrstuwyxz', 5);
  
  static String get accessLogUid =>  'accesslog-uid-${nanoid(18)}';
  
  static String get debugLogId => 'debugLog-uid-${nanoid(26)}';
  
  static String get firestoreUid => 'firestore-uid-${nanoid(13)}';

  static String get invitationCode => customAlphabet('1234567890ABCDEFGHIJKLMNOPQRSTUWYXZ', 8); 

  static String get userAccessCode => customAlphabet('1234567890ABCDEFGHIJKLMNOPQRSTUWYXZ', 12); 
}
