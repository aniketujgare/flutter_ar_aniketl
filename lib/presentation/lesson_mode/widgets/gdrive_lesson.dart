import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class GdriveLesson extends StatelessWidget {
  const GdriveLesson({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('GDRIVE FILE'),
          25.verticalSpacer,
          ElevatedButton(
            onPressed: () {
              _launchUrl(url);
            },
            child: Text('Open File'),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch ${url}');
  }
}
