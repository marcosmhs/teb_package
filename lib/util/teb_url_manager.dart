import 'package:url_launcher/url_launcher_string.dart';

class TebUrlManager {
  static Future<bool> launchUrl({required String url, bool checkUrl = true}) async {
    if (!checkUrl) {
      launchUrlString(url);
      return true;
    } else {
      if (await canLaunchUrlString(url)) {
        launchUrlString(url);
        return true;
      } else {
        return false;
      }
    }
  }

  static launchEmail({required String email}) async {
    if (email.isEmpty) return;

    if (await canLaunchUrlString(email)) {
      await launchUrlString(email);
    } else {
      throw 'Não consegui abrir o link';
    }
  }
}
