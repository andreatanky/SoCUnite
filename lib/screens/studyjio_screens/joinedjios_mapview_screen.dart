import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:SoCUniteTwo/widgets/provider_widget.dart';

class JoinedjiosMapviewScreen extends StatefulWidget {
  final bool isSelecting;

  JoinedjiosMapviewScreen({
    this.isSelecting = false,
  });

  @override
  _JoinedjiosMapviewScreenState createState() => _JoinedjiosMapviewScreenState();
}

class _JoinedjiosMapviewScreenState extends State<JoinedjiosMapviewScreen> {
  //GoogleMapController _controller;
  //Stream<QuerySnapshot> allStudyjiosOnMap;
  List<Marker> allMarkers = [];
  List<DocumentSnapshot> allStudyjios = [];
  List<GeoPoint> places = [GeoPoint(1.294260,103.774320), GeoPoint(1.296750,103.773148)];

  // @override
  // void initState() {
  //   super.initState();
    
  //   places.forEach((element) {
  //     allMarkers.add(
  //     Marker(
  //       markerId: MarkerId('myMarker'),
  //       draggable: false,
  //       //infoWindow: InfoWindow(title: AddStudyJioScreen.showTitleforMap,),
  //       position: LatLng(element.latitude, element.longitude),
  //       onTap: () {
  //         print('this works');
  //       }
  //     )
  //     );
  //   });    
  // }
  // setState(() {
  //   allMarkers = _retrieveStudyjios();
  // });
  // }
   
    //allStudyjiosOnMap = getUsersBrowseStudyjiosSnapshot(context);
    // Stream<QuerySnapshot> allStudyjiosOnMap = Firestore.instance
    //   .collection('browse_jios')
    //   .snapshots();
    //print(allStudyjiosOnMap.toString());
    // getUsersBrowseStudyjiosSnapshot(context).forEach((element) {
    //   element.documents.asMap().forEach((key, value) {
    //     allStudyjios.add(element.documents[key]);
    //   });
    // });
    // allStudyjios.forEach((element) {   
    //   allMarkers.add(
    //     Marker(
    //       markerId: MarkerId('myMarker'),
    //       draggable: false,
    //       infoWindow: InfoWindow(title: element.data['title'], snippet: element.data['date']), // title, date & time
    //       position: LatLng(element.data['locationOnMap'].latitude, element.data['locationOnMap'].longitude),
    //       onTap: () {
                       
    //       },
    //     )
    //   );
    // });
    //});
  //}

  // void _onMapCreated(controller) {
  //   setState(() {
  //     _controller = controller;
  //   });
  // }  

  _retrieveStudyjios() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    var result = await Firestore.instance.collection('users').document(uid)
    .collection('joined_studyjios')
    .getDocuments();
    List<Marker> testMarkers = [];
    result.documents.forEach((element) {
      //print('BEFORE adding marker');
        testMarkers.add(
        Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        infoWindow: InfoWindow(
          title: element.data['title'],
          snippet: element.data['date'] + ' ' + element.data['startTime'] + ' to ' + element.data['endTime']
        ),
        position: LatLng(element.data['locationOnMap'].latitude, element.data['locationOnMap'].longitude),
        onTap: () {
          
        }
      )
    );  
    //print('AFTER adding marker');
    // setState(() {
    //   allMarkers = testMarkers;
    // });
    });
    print(testMarkers);
    return testMarkers;
  }

 @override
  Widget build(BuildContext context) {
    //_retrieveStudyjios();
    //print(allMarkers);
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
        return FutureBuilder(
          future: _retrieveStudyjios(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {    
              return Container(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                  target: LatLng(
                    1.294260, 
                    103.77431999999999,
                  ),
                  zoom: 16,
                  ),
                  markers: Set.from(snapshot.data),
                ),
              );       
            } else {
              print(snapshot.data);
              return Container(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                  target: LatLng(
                    1.29426, 
                    103.77432,
                  ),
                  zoom: 16,
                  ),
                  markers: Set.from(snapshot.data),
                ),
              );
            }           
          }
        );
        }
      )
    );  
}

      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(
      //       1.294260, 
      //       103.77431999999999,
      //     ),
      //     zoom: 16,
      //   ),
      //   markers: Set.from(allMarkers),
      // ),
  
}