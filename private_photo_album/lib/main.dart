import 'package:flutter/material.dart';
import 'package:private_photo_album/providers/themes.dart';
import 'package:private_photo_album/screens/gallery_screen.dart';
import 'package:private_photo_album/screens/home_screen.dart';
import 'package:private_photo_album/screens/tab_screen.dart';
import 'package:private_photo_album/screens/add_photo_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Themes>(create: (_) => Themes(ThemeData.dark())),
      ],
      child: Container(
        child: MaterialAppWithTheme(),
      ),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<Themes>(context);
    return MaterialApp(
      title: 'My Photo Album',
      theme: theme.getTheme(),
      routes: {
        '/': (context) => HomeScreen(),
        TabScreen.routeName: (context) => TabScreen(),
        GalleryScreen.routeName: (context) => GalleryScreen(),
        AddPhotoScreen.routeName: (context) => AddPhotoScreen(),
      },
    );
  }
}
