// ignore_for_file: prefer_const_constructors_in_immutables, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ImageNetworkWithLoader extends StatelessWidget {
  final String url;

  ImageNetworkWithLoader(this.url);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: InteractiveViewer(
        minScale: 0.1,
        maxScale: 4,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
