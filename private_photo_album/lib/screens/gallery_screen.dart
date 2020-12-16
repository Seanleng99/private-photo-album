import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:private_photo_album/providers/pictures.dart';
import 'package:private_photo_album/widgets/image_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryScreen extends StatelessWidget {
  static const routeName = '/gallery_screen';
  @override
  Widget build(BuildContext context) {
    final imagesData = Provider.of<Pictures>(context);
    final images = imagesData.items;
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(10.0),
      crossAxisCount: 4,
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
      itemCount: images.length,
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: images[i],
        child: ImageItem(),
      ),
      staggeredTileBuilder: (i) => 
      new StaggeredTile.count(2, i.isEven ? 2 : 1),
    );
  }
}
