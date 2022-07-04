import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:tubes/Provider/googleSignIn.dart';
import 'package:tubes/pages/auth_log_page.dart';
import 'package:tubes/pages/detail_tempat_wisata.dart';
import 'package:tubes/pages/login_page.dart';
import 'package:tubes/pages/tambah_data.dart';
import 'package:tubes/pages/detail_tempat_wisata.dart';
import 'package:tubes/widgets/appText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:async/async.dart';
// import 'package:firebase_storage/firebase_storage.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class Home extends StatelessWidget {
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Home({Key? key}) : super(key: key);

  

  final user = FirebaseAuth.instance.currentUser!;
  final userInstance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: const Center(
          child: ExampleParallax(),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(240, 98, 189, 175),
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image:
                            AssetImage('assets/image/akghfdkghaf98217394.png'),
                        fit: BoxFit.cover,
                      )),
                  child: 
                    Text(
                      user.displayName != null?'Horas '+ user.displayName!:"Horas "+user.email!,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ListTile(
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.add,
                ),
                title: const Text('Tambah Data'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FormInputData()));
                },
              ),
              ListTile(
                minLeadingWidth: 0,
                leading: const Icon(
                  Icons.logout_rounded,
                ),
                title: user.displayName != null
                    ? Text(user.displayName!)
                    : Text('Keluar '+user.email!),
                onTap: () {
                  final provider =
                      Provider.of<GoogleSingInProvider>(context, listen: false);
                  userInstance.signOut();
                  provider.googleLogOut().whenComplete(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthLog(),
                      ));
                  });
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          toolbarOpacity: 0.5,
          bottomOpacity: 0.5,
          centerTitle: true,
          //key: _scaffoldKey,
          backgroundColor: const Color.fromARGB(
              180, 255, 255, 255), //Color.fromARGB(171, 58, 170, 153),
          elevation: 0,
          title: const Text(
            'Explore SUMUT',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(240, 0, 0, 0),
            ),
          ),
          shadowColor: const Color.fromARGB(0, 0, 0, 0),
          leading: Builder(
              builder: (BuildContext context) => IconButton(
                    //icon: FaIcon(FontAwesomeIcons.list, size: 21,),
                    icon: const Icon(
                      Icons.menu_rounded,
                      size: 35,
                      color: Color.fromARGB(240, 0, 0, 0),
                    ),
                    color: const Color.fromARGB(240, 0, 0, 0),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  )),
          actions: [
            // Container(
            //   width: 30,
            //   child: Image.network(
            //     user.photoURL!
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.all(8),
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  image: DecorationImage(
                      image: user.photoURL != null
                          ? NetworkImage(user.photoURL!)
                          : const NetworkImage(
                              'https://th.bing.com/th/id/R.47d1cc4b137f211cb1c3dfa2135bacba?rik=ZyqfGjPxlsy%2fcQ&riu=http%3a%2f%2fgenslerzudansdentistry.com%2fwp-content%2fuploads%2f2015%2f11%2fanonymous-user.png&ehk=dJX%2fxGNqMoZrDjZmTuHpot4p8blz6HCbhb%2bTyBYlXDU%3d&risl=&pid=ImgRaw&r=0'),
                      fit: BoxFit.fill),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromARGB(40, 0, 0, 0),
                  )),
            ),
            const SizedBox(
              width: 5,
            )
            //Icon(Icons.more_vert),
          ],
          //iconTheme: IconThemeData(color: Color.fromARGB(240, 0, 0, 0)),
        ),
      ),
    );
  }
}

class ExampleParallax extends StatefulWidget {
  const ExampleParallax({
    Key? key,
  }) : super(key: key);

  @override
  State<ExampleParallax> createState() => _ExampleParallaxState();
}

class _ExampleParallaxState extends State<ExampleParallax> {
  final user = FirebaseAuth.instance.currentUser!;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //get data from firebase firestore as stream
  Stream<QuerySnapshot> get dataStream {
    return firestore.collection('wisata').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: dataStream,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Data Kosong'),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((wisata) {
              print(wisata.id);
              return LocationListItem(
                id: wisata.data()['id'].toString(),
                imageUrl: wisata.data()['image'],
                name: wisata.data()['nama'],
                country: '',
                docName: wisata.id,
                deskripsi: wisata.data()['deskripsi'],
                imageLoc: wisata.data()['image'],
                place: wisata.data()['alamat'],
                lat: double.parse(wisata.data()['lat'] ?? '0'),
                long: double.parse(wisata.data()['long'] ?? '0'),
              );
            }).toList(),
          );
        }));
  }
}

class LocationListItem extends StatelessWidget {
  LocationListItem(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.docName,
      required this.country,
      required this.deskripsi,
      required this.imageLoc,
      required this.place,
      required this.lat,
      required this.long,
      required this.id})
      : super(key: key);

  final String imageUrl;
  final String name;
  final String docName;
  final String country;
  final String deskripsi;
  final String imageLoc, place;
  final double lat;
  final double long;
  final String id;

  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailTempatWisataScreen(
                alamat: place,
                deskripsi: deskripsi,
                id: id,
                lat: lat,
                docname: docName,
                long: long,
                nama: name,
                imageSrc: imageUrl,
                gambarLoc: imageLoc,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                _buildParallaxBackground(context),
                _buildGradient(),
                _buildTitleAndSubtitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context)!,
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Text(
              country,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  const Parallax({
    Key? key,
    required Widget background,
  }) : super(key: key, child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context)!);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context)!;
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    required ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    // Force the background to take up all available width
    // and then scale its height based on the image's aspect ratio.
    final background = child!;
    final backgroundImageConstraints =
        BoxConstraints.tightFor(width: size.width);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

    // Set the background's local offset, which is zero.
    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
        localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final scrollFraction =
        (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final background = child!;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}

class Location {
  const Location({
    required this.name,
    required this.place,
    required this.imageUrl,
    required this.deskripsi,
    required this.imageLoc,
  });

  final String name;
  final String place;
  final String imageUrl;
  final String deskripsi;
  final String imageLoc;
}

const locations = [
  Location(
    name: 'Danau Toba',
    place: 'Kab. Samosir, Sumatera Utara',
    imageUrl: 'assets/image/toba2.png',
    deskripsi:
        'Danau Toba adalah danau alami berukuran besar di Indonesia yang berada di kaldera Gunung Supervulkan. Danau ini memiliki panjang 100 kilometer (62 mil), lebar 30 kilometer (19 mi), dan kedalaman 505 meter (1.657 ft).',
    imageLoc: 'assets/image/loctoba.png',
  ),
  Location(
    name: 'Lau Kawar',
    place: 'Kuta Gugung, Kec. Naman Teran, Kabupaten Karo, Sumatera Utara',
    imageUrl: 'assets/image/lau kawar.png',
    deskripsi:
        'Danau Lau Kawar adalah wisata Sumatera Utara selain dari Danau Toba. Lokasi Danau Lau Kawar berada di kaki Gunung Sinabung, sehingga menjadi paduan keindahan alam yang eksotis.',
    imageLoc: 'assets/image/kawarLoc.png',
  ),
  Location(
    name: 'Taman Wisata Gunung Leuser',
    place: 'Kong Paluh, Kec. Kutapanjang, Kabupaten Gayo Lues, Aceh',
    imageUrl: 'assets/image/leuser.png',
    deskripsi:
        'Taman nasional ini mengambil nama dari Gunung Leuser yang menjulang tinggi dengan ketinggian 3404 meter di atas permukaan laut di Aceh. Taman nasional ini meliputi ekosistem asli dari pantai sampai pegunungan tinggi yang diliputi oleh hutan lebat khas hujan tropis',
    imageLoc: 'assets/image/leuserLoc.png',
  ),
  Location(
    name: 'Air Terjun Sipiso-piso',
    place: 'Pengambaten, Kec. Merek, Kabupaten Karo, Sumatera Utara',
    imageUrl: 'assets/image/sipiso.png',
    deskripsi:
        'Lokasi air terjun ini berada tidak jauh dari danau terbesar di Indonesia, yaitu Danau Toba. Air terjun yang berada pada ketinggian 800 meter ini terbentuk dari sungai bawah tanah di plato Karo yang mengalir melalui sebuah goa disisi kawah danau Toba',
    imageLoc: 'assets/image/sipisoLoc.png',
  ),
];
