import 'package:flutter/material.dart';
import 'package:ytdownload/video_parser.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _url = TextEditingController();
  String _id, _aUrl, _mvUrl, _vUrl, _pbs1, _pbs2, _pbs3;
  VideoParser _vp = VideoParser();

  void _fetchData() async {
//    await _vp.getVideo(url: _url.text).then((res) {
//      setState(() {
//        _id = res.title;
//      });
//    });
    await _vp.download(url: _url.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _url.text = "https://youtu.be/nJcWDwNyYXE";
    _url.text =
        "https://www.youtube.com/watch?v=kgZzOMIzLu0&list=RDMM8HnLRrQ3RS4&index=6";
    _id = "";
    _aUrl = "";
    _mvUrl = "";
    _vUrl = "";
    _pbs1 = "";
    _pbs2 = "";
    _pbs3 = "";
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
            Text(_id),
            SizedBox(height: 16.0),
            Text(_aUrl),
            SizedBox(height: 16.0),
            Text(_mvUrl),
            SizedBox(height: 16.0),
            Text(_vUrl),
            SizedBox(height: 16.0),
            Text(_pbs1),
            SizedBox(height: 16.0),
            Text(_pbs2),
            SizedBox(height: 16.0),
            Text(_pbs3),
          ],
        ),
      ),
    );
  }
}
