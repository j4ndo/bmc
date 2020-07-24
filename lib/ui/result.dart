import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  String _image;
  String _text;
  Result(this._image, this._text);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title: Text("Result"),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            _image,
            fit: BoxFit.fitWidth,
            height: 300.0,
          ),
          Center(
            child: Text(_text,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange[700], fontSize: 22.0)),
          )
        ],
      ),
    );
  }
}