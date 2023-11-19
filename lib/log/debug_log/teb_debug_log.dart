import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:teb_package/log/debug_log/teb_debug_log_data.dart';
import 'package:teb_package/teb_package.dart';

class TebDebugLog {
  final _debugLogCollectionName = 'debugLog';

  TebDebugLog({required FirebaseFirestore fireStoreInstance, String? group, required String message}) {
    var tebDebugLogData = TebDebugLogData(
      id: TebUidGenerator.firestoreUid,
      group: group,
      dateTime: DateTime.now(),
      message: message,
    );
    fireStoreInstance.collection(_debugLogCollectionName).doc(tebDebugLogData.id).set(tebDebugLogData.toMap);
    if (kDebugMode) {
      print(tebDebugLogData.log);
    }
  }
}
