import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:private_photo_album/screens/photo_detail_screen.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = '/gallery_screen';

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final picker = ImagePicker();
  CollectionReference imgColRef;

  @override
  void initState() {
    imgColRef = FirebaseFirestore.instance.collection('imageURLs');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: imgColRef.snapshots(includeMetadataChanges: true),
          builder: (context, snapshot) {
            if (snapshot.data?.documents == null || !snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Hero(
              tag: 'imageHero',
              child: Container(
                child: StaggeredGridView.countBuilder(
                  padding: const EdgeInsets.all(10.0),
                  crossAxisCount: 2,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 0))
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: snapshot.data.documents[index].get('url'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return PhotoDetailScreen(
                              snapshot.data.documents[index].get('url'),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  staggeredTileBuilder: (i) =>
                      new StaggeredTile.count(1, i.isEven ? 1 : 2),
                ),
              ),
            );
          }),
    );
  }
}
