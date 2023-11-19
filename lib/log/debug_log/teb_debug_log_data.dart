import 'package:teb_package/util/teb_util.dart';

class TebDebugLogData {
  final String id;
  final DateTime dateTime;
  final String? group;
  final String message;

  TebDebugLogData({
    required this.id,
    required this.dateTime,
    required this.group,
    required this.message,
  });

  Map<String, dynamic> get toMap {
    Map<String, dynamic> r = {};
    r = {
      'id': id,
      'dateTime': dateTime.toString(),
      'group': group,
      'stateCode': message,
    };

    return r;
  }

  String get log {
    // dd/mm/yyyy - hh:mm:ss - group - message
    return '${TebUtil.dateTimeFormat(date: dateTime, mask: ' dd/MM/yyyy - HH:mm:ss')} - ${group == null ? '' : '$group - '}$message';
  }
}
