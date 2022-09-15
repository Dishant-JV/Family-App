import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  GoogleMapController? googleMapController;
  List<Marker> markerList = [];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.1702, 72.8311),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Google map"),
        actions: [
          TextButton(
              onPressed: () {
                print("pressed");
                print(markerList);
                markerList.forEach((element) {
                  if (element.markerId == MarkerId("original")) {
                    googleMapController?.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: element.position, zoom: 20, tilt: 50)));
                  }
                });
              },
              child: Text(
                "Origin",
                style: TextStyle(color: Colors.green.shade700),
              )),
          TextButton(
              onPressed: () {
                markerList.forEach((element) {
                  if (element.markerId == MarkerId("destination")) {
                    googleMapController?.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: element.position, zoom: 20, tilt: 50)));
                  }
                });
              },
              child: Text(
                "Dest",
                style: TextStyle(color: Colors.blue.shade700),
              )),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        markers: markerList.map((e) => e).toSet(),
        onLongPress: setMarker,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _makeDirection,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  void setMarker(LatLng pos) {
    if (markerList.isEmpty) {
      markerList.add(Marker(
        markerId: MarkerId("original"),
        draggable: true,
        position: pos,
        infoWindow: InfoWindow(
          title: "Original",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
    } else {
      markerList.add(Marker(
          markerId: MarkerId('destination'),
          draggable: true,
          position: pos,
          infoWindow: InfoWindow(
            title: "Destination",
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      print(markerList.length);
      if (markerList.length == 3) {
        markerList.removeAt(1);
      }
      print(markerList.length);
      setState(() {});
    }
  }

  Future<void> _makeDirection() async {
    Marker? original;
    Marker? dest;
    markerList.forEach((element) {
      if (element.markerId == MarkerId("original")) {
        original = element;
      } else {
        dest = element;
      }
    });
    var params = {
      'origin':
          '${original?.position.latitude},${original?.position.longitude}',
      'destination': '${dest?.position.latitude},${dest?.position.longitude}',
      'key': 'AIzaSyCGShAceyIm1LHL2mLja0eKCKDjoZV2RzY'
    };
    Uri uri = Uri.parse("https://maps.googleapis.com/maps/api/directions/json");
    final finalUri = uri.replace(queryParameters: params);
    final response = await http.get(finalUri);
    print(response.statusCode);
    print(response.body);
  }
}
