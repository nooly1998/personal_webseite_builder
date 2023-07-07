import 'package:url_launcher/url_launcher.dart';

//定义方法
launchURL(url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
