import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import 'package:ymmi_coonectv2/page/absensi_portal.dart';
import 'package:ymmi_coonectv2/page/diskusi.dart';
import 'package:ymmi_coonectv2/page/konsultasi_hr.dart';
import 'package:ymmi_coonectv2/page/lapor_absen.dart';
import 'package:ymmi_coonectv2/page/slip_gaji.dart';
import 'package:ymmi_coonectv2/utils/user_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<List> _streamController = StreamController<List>();
  var imagePath = [];

  var imageSlide = <Widget>[];

  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    _getHeaderSlide();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < imagePath.length; i++) {
      imageSlide.add(imagePath[i]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "YMMI Connect",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text("YMMI CONNECT"),
            ),
            _buildListTile(
                context: context,
                route: const AbsensiPortal(),
                text: 'Absensi Portal'),
            _buildDivider(),
            _buildListTile(
                context: context,
                route: const LaporAbsen(),
                text: 'Laporan Tidak Hadir'),
            _buildDivider(),
            _buildListTile(
                context: context, route: const SlipGaji(), text: 'Slip Gaji'),
            _buildDivider(),
            _buildListTile(
                context: context,
                route: const Diskusi(),
                text: 'Ruang Diskusi'),
            _buildDivider(),
            _buildListTile(
                context: context,
                route: const Konsultasi(),
                text: 'Konsultasi HR'),
            Container(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _deleteUsername();
                  });
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Log Out'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            // for (var item in imagePath) Text(item['img_dir']),
            FutureBuilder(
                future: _getHeaderSlide(),
                // stream: _streamController.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Object? list = snapshot.data;
                        if (snapshot.hasData) {
                          // return Image.network(
                          //     'http://192.168.42.12/android/pegawai/slide_image/${list[index]['image']}');
                          for (var item in imagePath) {
                            return Image(
                              image: AssetImage(item['img_dir']),
                            );
                          }
                          // return Text()
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      });
                  /*
                  if (snapshot.hasData) {
                    Map item;
                    var newww = snapshot.data;
                    return ListView(
                      children: [
                        for (Map item in snapshot.data!)
                          Text(item['img_dir'].toString()),
                        // usrMap.forEach((k,v) => print('${k}: ${v}'));
                      ],
                    );
                    */
                  // for (var item in imagePath) {
                  //   return Image(
                  //     image: AssetImage(item['img_dir']),
                  //   );
                  // }
                  // }
                  return const SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  );
                }),
            ImageSlideshow(
                width: double.infinity,
                height: 200,
                initialPage: 0,
                autoPlayInterval: 5000,
                indicatorColor: Colors.blue,
                indicatorBackgroundColor: Colors.grey,
                isLoop: true,
                children: [
                  // imageSlide,

                  Container(
                    child: const Card(
                      child: Image(
                        image: AssetImage('images/slideshow/slide1.png'),
                      ),
                    ),
                  ),
                  Container(
                    child: const Card(
                      child: Image(
                        image: AssetImage('images/slideshow/slide2.png'),
                      ),
                    ),
                  ),
                ]),
            SizedBox(
              height: 5,
            ),
            Text('Hallo'),
            ElevatedButton(
                onPressed: () {
                  _getHeaderSlide().toString();
                  print(_getHeaderSlide().toString());
                },
                child: Text('Touch Me'))
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile({
    required BuildContext context,
    required Widget route,
    required String text,
  }) {
    return ListTile(
      title: Text(text),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => route,
          ),
        );
      },
    );
  }

  Divider _buildDivider() {
    return const Divider(
      height: 1,
      indent: 20,
      endIndent: 100,
      color: Colors.black38,
    );
  }

  void _deleteUsername() {
    UserSecureStorage.deleteUsername();
  }

  Future _getHeaderSlide() async {
    // untuk emulator
    // Uri url = Uri.parse('http://10.0.2.2/android/pegawai/login.php');

    // untuk real device
    Uri url = Uri.parse('http://192.168.42.12/android/pegawai/show_image.php');
    final resp = await http.post(url, body: {
      'img_dir': imagePath,
    });

    Map<String, dynamic> json = {};

    var getImagesResp = await http.get(url);

    List data = jsonDecode(getImagesResp.body);

    // if (getImagesResp.statusCode == 200) {
    //   return Album.fromJson(jsonDecode(getImagesResp.body));
    // } else {
    //   throw Exception('Failed to load image');
    // }

    _streamController.add(data);
  }
}

class Album {
  final int id;
  var name;
  final String img_dir;

  Album({
    required this.id,
    required this.name,
    required this.img_dir,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      img_dir: json['img_dir'],
    );
  }
}
