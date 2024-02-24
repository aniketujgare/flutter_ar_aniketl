import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/styles.dart';

class YoutubeVideoLesson extends StatefulWidget {
  const YoutubeVideoLesson({super.key, required this.ytUrl});
  final String ytUrl;

  @override
  State<YoutubeVideoLesson> createState() => _YoutubeVideoLessonState();
}

class _YoutubeVideoLessonState extends State<YoutubeVideoLesson> {
  late final PodPlayerController controller;
  bool isLoading = true;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: AppColors.accentColor));

    loadVideo();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    super.dispose();
  }

  void loadVideo() async {
    final urls = await PodPlayerController.getYoutubeUrls(
      widget.ytUrl,
    );
    setState(() => isLoading = false);
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.networkQualityUrls(videoUrls: urls!),
      podPlayerConfig:
          const PodPlayerConfig(videoQualityPriority: [360], autoPlay: false),
    )..initialise();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: screenSize.width * 0.65,
                      // height: screenSize.width * 0.5,
                      child: PodVideoPlayer(
                        controller: controller,
                        alwaysShowProgressBar: true,
                        onToggleFullScreen: (isFS) async {},
                      )),
                ),
              )
      ],
    );
  }
}
