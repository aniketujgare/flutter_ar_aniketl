import 'dart:io';

import 'package:connection_notifier/connection_notifier.dart';
import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/reusable_widgets/network_disconnected.dart';

class AssetDownload extends StatefulWidget {
  const AssetDownload({super.key});

  @override
  AssetDownloadState createState() => AssetDownloadState();
}

class AssetDownloadState extends State<AssetDownload> {
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  String message = 'Press the download button to start the download';
  bool downloaded = false;
  double value = 0.0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future _init() async {
    await downloadAssetsController.init();
    downloaded = await downloadAssetsController.assetsDirAlreadyExists();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Asset Download test'),
        ),
        body: ConnectionNotifierToggler(
          disconnected: const NetworkDisconnected(),
          connected: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(message),
                if (downloaded) ...[
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(
                            '${downloadAssetsController.assetsDir}/image_1.png')),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(
                            '${downloadAssetsController.assetsDir}/flutter.png')),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _downloadAssets,
              tooltip: 'Download',
              child: const Icon(Icons.arrow_downward),
            ),
            const SizedBox(
              width: 25,
            ),
            FloatingActionButton(
              onPressed: () async {
                await downloadAssetsController.clearAssets();
                await _downloadAssets();
              },
              tooltip: 'Refresh',
              child: const Icon(Icons.refresh),
            ),
            const SizedBox(
              width: 25,
            ),
            FloatingActionButton(
              onPressed: _cancel,
              tooltip: 'Cancel',
              child: const Icon(Icons.cancel_outlined),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );

  Future _downloadAssets() async {
    final assetsDownloaded =
        await downloadAssetsController.assetsDirAlreadyExists();

    if (assetsDownloaded) {
      setState(() {
        message = 'Click in refresh button to force download';
        debugPrint(message);
        debugPrint(downloadAssetsController.assetsDir);
      });
      return;
    }

    try {
      value = 0.0;
      await downloadAssetsController.startDownload(
        onCancel: () {
          message = 'Cancelled by user';
          setState(() {});
        },
        assetsUrls: [
          'https://github.com/edjostenes/download_assets/raw/main/download/image_1.png',
          // 'https://github.com/edjostenes/download_assets/raw/main/download/assets.zip',
          // 'https://github.com/edjostenes/download_assets/raw/main/download/image_2.png',
          // 'https://github.com/edjostenes/download_assets/raw/main/download/image_3.png',
        ],
        onProgress: (progressValue) {
          downloaded = false;
          value = progressValue;
          setState(() {
            downloaded = progressValue >= 100.0;
            message = 'Downloading - ${progressValue.toStringAsFixed(2)}';
            debugPrint(message);

            if (downloaded) {
              message =
                  'Download completed\nClick in refresh button to force download';
            }
          });
        },
      );
    } on DownloadAssetsException catch (e) {
      debugPrint(e.toString());
      setState(() {
        downloaded = false;
        message = 'Error: ${e.toString()}';
      });
    }
  }

  void _cancel() => downloadAssetsController.cancelDownload();
}
