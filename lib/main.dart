import 'package:flutter/material.dart';
import 'ui/result.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "";

  void _resetFields() {
    _formKey.currentState.reset();
    weightController.clear();
    heightController.clear();
    setState(() {
      _infoText = "";      
    }); 
  }

  void _calculateBMC() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double bmc = weight / (height * height);
    setState(() {
      if (bmc < 18.6) {
        _infoText = "Your BMC is under weight: (${bmc})";
        Navigator.push(context,  MaterialPageRoute(builder: (context) => Result("images/under.jpg", _infoText)));
      } else if (bmc >= 30.0){
        _infoText = "Your BMC is overweight: (${bmc})";
        Navigator.push(context,  MaterialPageRoute(builder: (context) => Result("images/overweight.jpg", _infoText)));

      } else {
        _infoText = "Your BMC is normal: (${bmc})";
        Navigator.push(context,  MaterialPageRoute(builder: (context) => Result("images/ok.jpg", _infoText)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BMC Calculator"),
          centerTitle: true,
          backgroundColor: Colors.orange[300],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: 
          Form(
            key: _formKey,
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Icon(
                  //   Icons.person,
                  //   size: 120.0,
                  //   color: Colors.red,
                  // ),
                  Image.asset(
                    'images/BMC.jpg',
                    fit: BoxFit.fitWidth,
                    // height: 2000,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(                    
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Weight (kg)",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 25.0),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) { 
                        return "Type your Weight!";
                      }
                    },
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Height (cm)",
                          labelStyle: TextStyle(color: Colors.black)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 25.0),
                      controller: heightController,
                      validator: (value) {
                      if (value.isEmpty) { 
                        return "Type your Height!";
                      }
                    },),
                  ),     
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) _calculateBMC();
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.orange[300],
                    ),
                  ),
                  ),                               
                  Text(_infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange[300], fontSize: 20.0))
                ],
              ),
          ),
        ));
  }
}
