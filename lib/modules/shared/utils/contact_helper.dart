import 'package:url_launcher/url_launcher.dart';

class ContactHelper {
  static void whatsapp(String phone) {
    String whatsappUrl = 'whatsapp://send?phone=+55$phone';
    launchUrl(Uri.parse(whatsappUrl));
  }

  static void call(String phone) {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    launchUrl(launchUri);
  }
}
