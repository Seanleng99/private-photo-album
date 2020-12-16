import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  String _locationMessage = "";

  void _getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Location Services"),
        ),
        body: Align(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_locationMessage),
                FlatButton(
                  onPressed: () {
                    _getCurrentLocation();
                  },
                  color: Colors.blue,
                  child: Text("Find Location"),
                ),
              ]),
        ),
      ),
    );
  }
}
