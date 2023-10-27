import 'package:url_launcher/url_launcher_string.dart';

class TebUrlManager {
  static launchUrl({required String url}) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Não consegui abrir o link $url';
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
