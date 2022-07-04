///
/// AVANCED EXAMPLE:
/// Screen with map and search box on top. When the user selects a place through autocompletion,
/// the screen is moved to the selected location, a path that demonstrates the route is created, and a "start route"
/// box slides in to the screen.
///

// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class MapLocation extends StatefulWidget {
  MapLocation({
    Key? key,
  }) : super(key: key);

  @override
  State<MapLocation> createState() => MapLocationState();
}

class MapLocationState extends State<MapLocation>
    with SingleTickerProviderStateMixin {
  PickResult? selectedPlace;
  static LatLng kInitialPosition =
      LatLng(-6.1621646, 106.826624); // London , arbitary value
  Position? currentPosition;
  late GoogleMapController _controller;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller.setMapStyle(value);
    setState(() {});
  }

  getCurrentLocation() async {
    currentPosition = await _getGeoLocationPosition();
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    setDummyInitialLocation();
  }

  setDummyInitialLocation() {
    if (currentPosition != null) {
      kInitialPosition = LatLng(currentPosition!.latitude,
          currentPosition!.longitude); // London , arbitary value
    }
    setState(() {});
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    //requestPermission();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.requestPermission();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  onTapPickHere(PickResult selectedPlace) async {
    Navigator.pop(context, selectedPlace);
  }

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      hintText: 'Your location',
      apiKey: 'AIzaSyAu2sB_J64tkHpodpMuRO5-6qbWLEA82bc',
      initialPosition: kInitialPosition,
      useCurrentLocation: true,
      //selectInitialPosition: true,
      onMapCreated: _onMapCreated,
      //initialMapType: MapType.terrain,

      //usePlaceDetailSearch: true,
      onPlacePicked: (result) {
        selectedPlace = result;
        Navigator.of(context).pop();
        setState(() {});
      },
      //forceSearchOnZoomChanged: true,
      //automaticallyImplyAppBarLeading: false,
      //autocompleteLanguage: "ko",
      //region: 'au',
      //selectInitialPosition: true,
      selectedPlaceWidgetBuilder:
          (_, selectedPlace, state, isSearchBarFocused) {
        print("state: $state, isSearchBarFocused: $isSearchBarFocused");
        print(selectedPlace.toString());
        print("-------------");
        /*
        if(!isSearchBarFocused && state != SearchingState.Searching){
          ToastComponent.showDialog("Hello", context,
              gravity: Toast.center, duration: Toast.lengthLong);
        }*/
        return isSearchBarFocused
            ? Container()
            : FloatingCard(
                height: 50,
                bottomPosition: 120.0,
                // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                leftPosition: 0.0,
                rightPosition: 0.0,
                width: 500,
                borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(8.0),
                  bottomLeft: const Radius.circular(8.0),
                  topRight: const Radius.circular(8.0),
                  bottomRight: const Radius.circular(8.0),
                ),
                child: state == SearchingState.Searching
                    ? Center(
                        child: Text(
                        'Searching...',
                        style: TextStyle(color: Colors.black),
                      ))
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2.0, right: 2.0),
                                    child: Text(
                                      selectedPlace!.formattedAddress!,
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.only(
                                  topLeft: const Radius.circular(4.0),
                                  bottomLeft: const Radius.circular(4.0),
                                  topRight: const Radius.circular(4.0),
                                  bottomRight: const Radius.circular(4.0),
                                )),
                                child: Text(
                                  'Pick Here',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  onTapPickHere(selectedPlace);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              );
      },
      pinBuilder: (context, state) {
        if (state == PinState.Idle) {
          return Icon(
            Icons.location_on,
            size: 30,
            color: Colors.blue,
          );
        } else {
          return Icon(
            Icons.location_on,
            size: 30,
            color: Colors.blue,
          );
        }
      },
    );
  }
}
