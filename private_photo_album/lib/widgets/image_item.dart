import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:private_photo_album/models/picture.dart';

class ImageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pic = Provider.of<Picture>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(blurRadius: 20),
        ],
      ),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 250,
      child: Image.file(
        pic.picName,
        fit: BoxFit.cover,
      ),
    );
  }
}
