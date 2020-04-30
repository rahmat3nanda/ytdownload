import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:ytdownload/app_util.dart';

class VideoParser {
  var yt = YoutubeExplode();
  var progress;

  Future<Video> getVideo({@required String url}) async {
    var id = YoutubeExplode.parseVideoId(url);
    var video = await yt.getVideo(id);
//    // Close the YoutubeExplode's http client.
//    yt.close();
    return video;
  }

  Future download({@required String url}) async {
    var path;
    progress = 0;
    await AppUtil.createFolderInAppDocDir().then((res) {
      path = res;
    }).catchError((e) {
      print(e.toString());
    });
    var id = YoutubeExplode.parseVideoId(url);
    // Get the video media stream.
    var mediaStream = await yt.getVideoMediaStream(id);

    // Get the last video track (the one with the highest bitrate).
    var video = mediaStream.video.last;
    for (int i = 0; i < mediaStream.video.length; i++) {
      print(mediaStream.video[i].container
          .toString()
          .replaceAll('Container.', '')
          .replaceAll(r'\', '')
          .replaceAll('/', '')
          .replaceAll('*', '')
          .replaceAll('?', '')
          .replaceAll('"', '')
          .replaceAll('<', '')
          .replaceAll('>', '')
          .replaceAll('|', ''));
    }
    var stamp = DateTime.now().millisecondsSinceEpoch;
    // Compose the file name removing the unallowed characters in windows.
    var fileName =
        '${mediaStream.videoDetails.title}-$stamp.${video.container.toString()}'
            .replaceAll('Container.', '')
            .replaceAll(r'\', '')
            .replaceAll('/', '')
            .replaceAll('*', '')
            .replaceAll('?', '')
            .replaceAll('"', '')
            .replaceAll('<', '')
            .replaceAll('>', '')
            .replaceAll('|', '');
    var file = new File('$path/$fileName');
    print(path);
    print(fileName);

    // Create the StreamedRequest to track the download status.

    // Open the file in appendMode.
    var output = file.openWrite(mode: FileMode.writeOnlyAppend);

    // Track the file download status.
    var len = video.size;
    var count = 0;
    var oldProgress = -1;

    // Create the message and set the cursor position.
    var msg = 'Downloading `${mediaStream.videoDetails.title}`:  \n';
    var col = msg.length - 2;
    print(msg);

    // Listen for data received.
    await for (var data in video.downloadStream()) {
      count += data.length;
      progress = ((count / len) * 100).round();
      if (progress != oldProgress) {
        print('$progress%');
        oldProgress = progress;
      }
      output.add(data);
    }
  }

  getCounter() {
    return progress ?? 0;
  }
}
