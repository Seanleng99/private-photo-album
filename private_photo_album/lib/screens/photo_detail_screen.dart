import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatefulWidget {
  final String url;
  PhotoDetailScreen(this.url);

  @override
  _PhotoDetailScreenState createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends State<PhotoDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              child: Center(
                child: Hero(
                  tag: 'imageHero',
                  child: Image.network(widget.url),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
