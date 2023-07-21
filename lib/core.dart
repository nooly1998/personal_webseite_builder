import 'package:flutter/material.dart';

enum DownloadStatus {
  notDownloaded,
  fetchingDownload,
  downloading,
  downloaded,
}

Drawer lDrawer<T>(Future<T> value, BuildContext context) {
  return Drawer(
    width: 100,
    child: FractionallySizedBox(
      widthFactor: 0.3,
      child: FutureBuilder<List<dynamic>>(
        future: Future.wait([value]),
        builder: (context, snap) {
          if (snap.error != null) {
            // An error has been encountered, so give an appropriate response and
            // pass the error details to an unobstructive tooltip.
            debugPrint(snap.error.toString());
          }
          final data = snap.data;
          final List<String> list = data?[0];
          return Column(
            children: [
              Text(list[0]),
              Text(list[1]),
            ],
          );
        },
      ),
    ),
  );
}
