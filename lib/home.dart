import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ytdownload/video_parser.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _url = TextEditingController();
  String _judul, _urlImage, _proses;
  VideoParser _vp = VideoParser();
  Timer _prosesChecker;

  void _fetchData() async {
    await _vp.getVideo(url: _url.text).then((res) {
      setState(() {
        _judul = res.title;
        _urlImage = res.thumbnailSet.mediumResUrl;
      });
    });
  }

  void _downloadData() async {
    _cekProses();
    await _vp.download(url: _url.text);
  }

  void _cekProses() {
    _prosesChecker = Timer(Duration(milliseconds: 500), () {
      var proses = _vp.getCounter() ?? 0;
      setState(() {
        _proses = proses.toString() + "%";
      });
      if (proses == 100) {
        _prosesChecker.cancel();
        _proses += " - Unduhan Selesai";
      } else {
        _cekProses();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _url.text = "https://youtu.be/nJcWDwNyYXE";
    _url.text =
        "https://www.youtube.com/watch?v=kgZzOMIzLu0&list=RDMM8HnLRrQ3RS4&index=6";
    _judul = "";
    _urlImage = "";
    _proses = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YT Download"),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: _url,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                hintText: 'URL',
                hintStyle: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                ),
                errorStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            FlatButton(
              child: Text(
                "Fetch",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                _fetchData();
              },
            ),
            SizedBox(height: 16.0),
            Text(_judul),
            SizedBox(height: 16.0),
            _urlImage.isEmpty ? Container() : Image.network(_urlImage),
            SizedBox(height: 16.0),
            _judul.isEmpty
                ? Container()
                : FlatButton(
                    child: Text(
                      "Download",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      _downloadData();
                    },
                  ),
            SizedBox(height: 16.0),
            Text(_proses),
          ],
        ),
      ),
    );
  }
}
