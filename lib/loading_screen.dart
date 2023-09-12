import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Future<void> loadingData;
  final Widget content;

  LoadingScreen({required this.loadingData, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadingData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(
              alignment: Alignment.center,
              children: [
                content,
                CircularProgressIndicator(),
              ],
            );
          } else {
            return content;
          }
        },
      ),
    );
  }
}
