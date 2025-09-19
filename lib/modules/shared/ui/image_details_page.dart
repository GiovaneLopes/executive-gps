import 'dart:io';
import 'package:executive_gps/libs/modules/employees/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageDetailsPage extends StatelessWidget {
  const ImageDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final image = ModalRoute.of(context)!.settings.arguments as ImageModel?;
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
                child: image?.url == null
                    ? Center(
                        child: Image.file(
                          File(image?.file?.path ?? ''),
                        ),
                      )
                    : Center(
                        child: CachedNetworkImage(
                          imageUrl: image?.url ?? '',
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
