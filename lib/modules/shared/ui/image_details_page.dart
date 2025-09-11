import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageDetailsPage extends StatelessWidget {
  final String? url;
  final String? filePath;
  const ImageDetailsPage({
    super.key,
    this.url,
    this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InteractiveViewer(
                child: url == null
                    ? Center(
                        child: Image.file(
                          File(filePath ?? ''),
                        ),
                      )
                    : Center(
                        child: CachedNetworkImage(
                          imageUrl: url ?? '',
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
