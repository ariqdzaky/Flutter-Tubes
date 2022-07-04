import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:tubes/Provider/googleSignIn.dart';
import 'package:tubes/model/toast.dart';
import 'package:tubes/pages/map_location.dart';
import 'package:tubes/widgets/responsiveButton.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class FormInputData extends StatefulWidget {
  const FormInputData({Key? key}) : super(key: key);

  @override
  _FormInputDataScreenState createState() => _FormInputDataScreenState();
}

class _FormInputDataScreenState extends State<FormInputData> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // late DateTime backButtonPressTime;

  @override
  // late BuildContext context;

  var nama = TextEditingController();
  var alamat = TextEditingController();
  var deskripsi = TextEditingController();
  String lat = '0';
  String lng = '0';

  get kHintTextStyleLabel => null;

  FirebaseStorage storage = FirebaseStorage.instance;
  bool show = false;
  late ImagePicker imagePicker;
  String valueImage = '';
  String filepath = '';
  void getimage1(ImageSource imageSource) async {
    // ignore: invalid_use_of_visible_for_testing_member
    PickedFile? file = await ImagePicker.platform
        .pickImage(source: imageSource, imageQuality: 70);
    if (file != null) {
      final image = File(file.path);

      var snapshot = await storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.png')
          .putFile(image)
          .whenComplete(() => print('Uploaded'));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        valueImage = downloadUrl;
      });
      filepath = file.path;
      show = true;
      setState(() {});
    }
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: const Color.fromARGB(240, 98, 189, 175)
              /*
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.green, Colors.blue])
              */
              ),
        ),
      ),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: <Widget>[
              _buildNama(),
              _buildAlamat(),
              _buildDeskripsi(),
              const SizedBox(
                height: 40,
              ),
              _photo(),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  final provider =
                      Provider.of<GoogleSingInProvider>(context, listen: false);
                  if (nama.text.isNotEmpty &&
                      alamat.text.isNotEmpty &&
                      deskripsi.text.isNotEmpty &&
                      valueImage.isNotEmpty &&
                      lat != '0' &&
                      lng != '0') {
                    provider.addWisata(context, nama.text, alamat.text,
                        deskripsi.text, valueImage, lat, lng);
                  } else {
                    ToastCustom.toastError('Data tidak boleh kosong');
                  }
                },
                child: responsiveButton(
                  text: "SUBMIT",
                  colors: Color.fromARGB(240, 98, 189, 175),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _photo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(5.0),
      ),
      width: double.infinity,
      height: 200,
      child: Stack(
        children: <Widget>[
          show == true
              ? Container(
                  width: double.maxFinite,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.file(
                      File(filepath),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : Image.asset(
                  "assets/logo/logo-bg-transparent.png",
                  width: double.maxFinite,
                  height: 200,
                  fit: BoxFit.contain,
                ),
          InkWell(
            onTap: () {
              myAlert();
            },
            child: const Center(
              child: Icon(
                Icons.camera_alt,
                size: 50,
                color: Color.fromARGB(200, 156, 156, 156),
              ),
            ),
          )
        ],
      ),
    );
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getimage1(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getimage1(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildNama() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            controller: nama,
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.drive_file_rename_outline,
                  color: Color.fromARGB(200, 156, 156, 156),
                ),
                hintText: "Masukan nama tempat wisata",
                hintStyle: kHintTextStyleLabel,
                labelText: "Nama",
                labelStyle: kHintTextStyleLabel,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(200, 156, 156, 156)),
                    borderRadius: BorderRadius.circular(5.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(200, 156, 156, 156)),
                    borderRadius: BorderRadius.circular(5.0))),
          ),
        ),
      ],
    );
  }

  Widget _buildAlamat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        InkWell(
          onTap: () async {
            PickResult data = await Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => MapLocation()));
            if (data.geometry != null) {
              alamat.text = data.formattedAddress!;
              lat = data.geometry!.location.lat.toString();
              lng = data.geometry!.location.lng.toString();
            }
          },
          child: AbsorbPointer(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 120.0,
              child: TextFormField(
                maxLines: 2,
                controller: alamat,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.place_outlined,
                      color: Color.fromARGB(200, 156, 156, 156),
                    ),
                    hintText: "Masukan Alamat  tempat wisata",
                    hintStyle: kHintTextStyleLabel,
                    labelText: "Alamat",
                    labelStyle: kHintTextStyleLabel,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(200, 156, 156, 156)),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(200, 156, 156, 156)),
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeskripsi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 120.0,
          child: TextFormField(
            maxLines: 15,
            controller: deskripsi,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.description,
                  color: Color.fromARGB(200, 156, 156, 156),
                ),
                hintText: "Masukkan Deskripsi tempat wisata",
                hintStyle: kHintTextStyleLabel,
                labelText: "Deskripsi",
                labelStyle: kHintTextStyleLabel,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(200, 156, 156, 156)),
                    borderRadius: BorderRadius.circular(5.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(200, 156, 156, 156)),
                    borderRadius: BorderRadius.circular(5.0))),
          ),
        ),
      ],
    );
  }
}
