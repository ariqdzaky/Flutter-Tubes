import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tubes/pages/edit_wisata.dart';
import 'package:tubes/pages/tambah_data.dart';

class DetailTempatWisataScreen extends StatefulWidget {
  DetailTempatWisataScreen({
    required this.nama,
    required this.alamat,
    required this.deskripsi,
    required this.lat,
    required this.long,
    required this.id,
    required this.docname,
    required this.imageSrc,
    required this.gambarLoc,
  });

  final String nama, alamat, id, deskripsi, imageSrc, gambarLoc, docname;
  final double lat, long;

  @override
  _DetailTempatWisataState createState() => _DetailTempatWisataState();
}

class _DetailTempatWisataState extends State<DetailTempatWisataScreen> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _kGooglePlex;
  CameraPosition? _kLake;
  final Set<Marker> _markers = {};
  bool _isLoading = false;
  initial() async {
    setState(() {
      false;
    });
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.long),
      zoom: 14.4746,
    );

    _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(widget.lat, widget.long),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    _markers.add(
      Marker(
        markerId: MarkerId("3.595196, 98.672226"),
        position: LatLng(widget.lat, widget.long),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    setState(() {
      _kGooglePlex = _kGooglePlex;
      _kLake = _kLake;
      print(_kGooglePlex);
      print(_kLake);
      _isLoading = true;
    });
  }

  Future<Set<Marker>> myMarkers() async {
    List<Marker> mMarkers = [];
    mMarkers.add(
      Marker(
        markerId: MarkerId('marker1'),
        position: LatLng(widget.lat, widget.long),
      ),
    );

    return mMarkers.toSet();
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Explore SUMUT',
          style: TextStyle(
            fontFamily: 'Inter',
          ),
        ),
        backgroundColor: const Color.fromARGB(240, 98, 189, 175),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormEditData(
                    id: widget.id,
                    nama: widget.nama,
                    alamat: widget.alamat,
                    deskripsi: widget.deskripsi,
                    lat: widget.lat,
                    docname: widget.docname,
                    long: widget.long,
                    imageSrc: widget.imageSrc,
                    gambarLoc: widget.gambarLoc,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          Image.network(
                            widget.imageSrc,
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 150),
                            width: double.maxFinite,
                            height: 100,
                            color: Colors.black26,
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 170, left: 10, right: 10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          widget.nama,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        Flexible(
                                          child: Text(
                                            widget.alamat,//alamat dari gmaps
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 230, left: 10, right: 10),//.symmetric
                            child: SizedBox(
                              width: double.infinity,
                              child: Card(
                                //filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                widget.deskripsi,
                                                textAlign: TextAlign.justify,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 400, horizontal: 50),
                          //   child: Card(
                          //     color: Colors.white,
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(
                          //           top: 0.0, bottom: 0.0),
                          //       child: Column(
                          //         children: <Widget>[
                          //           Image.network(
                          //             widget.gambarLoc,
                          //             height: 300.0,
                          //             width: 300.0,
                          //             fit: BoxFit.fill,
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  _isLoading == false
                      ? SizedBox()
                      : Container(
                          // decoration: const BoxDecoration(
                          //   borderRadius: BorderRadius.all(Radius.circular(20)),
                          // ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          child: GoogleMap(
                            markers: _markers,
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex!,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
