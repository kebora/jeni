import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:jeni/main_view.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;

void main() {
  runApp(
    GetMaterialApp(
      title: 'JENI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey repaintKey = GlobalKey();

    return RepaintBoundary(
      key: repaintKey,
      child: Scaffold(
        body: const MainView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Get the RenderRepaintBoundary object from the GlobalKey
            RenderRepaintBoundary? boundary = repaintKey.currentContext!
                .findRenderObject() as RenderRepaintBoundary;

            // Capture the image data from the RenderRepaintBoundary
            ui.Image image = await boundary.toImage();
            ByteData? byteData =
                await image.toByteData(format: ui.ImageByteFormat.png);
            Uint8List? pngBytes = byteData?.buffer.asUint8List();

            // Get the user's Downloads folder path
            String downloadsPath =
                (await path_provider.getDownloadsDirectory())!.path;

            // Save the image as a file in the Downloads folder
            String filePath = path.join(downloadsPath, 'my_flutter_image.png');
            final file = File(filePath);
            await file.writeAsBytes(pngBytes!);
          },
          child: const Icon(Icons.download),
        ),
      ),
    );
  }
}
