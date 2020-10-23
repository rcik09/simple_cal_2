import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  runApp(
      MaterialApp(
        title: 'Simple Interest Calculator App',
        home: SIForm(),
      )
  );
}

class SIForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ['JMD', 'USD', 'Pounds'];
  final double  _minimumPadding = 5.0;

  var _currentItemSelected = '';
  var displayResult = '';
  var  history = '';
  @override
  void initState() {


    super.initState();
    _getHistory().then((value) => {
      history = value.toString()
    });
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController       = TextEditingController();
  TextEditingController termController      = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
//			resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),

      body: Form(
        //margin: EdgeInsets.all(_minimumPadding * 2),
      key: _formKey,
      child: Padding(
      padding: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[

            getImageAsset(),

            Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: principalController,
                  validator: (String value){
                    if(value.isEmpty) {
                      return 'Please enter an appropriate Principal value.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal e.g. 12000',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )),

            Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: roiController,
                  validator: (String value){
                    if(value.isEmpty)
                        return "Please enter an appropriate Interest Rate";

                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'In percent',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )),

            Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[

                    Expanded(child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: termController,
                      validator: (String val){
                        if(val.isEmpty)
                          return "Please enter a term period";

                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in years',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    )),

                    Container(width: _minimumPadding * 5,),

                    Expanded(child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),//A list was here

                      value: _currentItemSelected,

                      onChanged: (String newValueSelected) {
                        // Your code to execute, when a menu item is selected from dropdown
                        _onDropDownItemSelected(newValueSelected);
                      },

                    ))


                  ],
                )),

            Padding(
                padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
                child: Row(children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text('Calculate'),
                      onPressed: () {
                        setState(() {

                          if(_formKey.currentState.validate()){
                            this.displayResult = _calculateTotalReturns();
                           // print("Hit calculate");
                          }

                         // print("not hit calculate");

                        });
                      },
                    ),
                  ),

                  Expanded(
                    child: RaisedButton(
                      child: Text('Reset'),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  ),

                ],)),


            Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: Text('Result: ' + this.displayResult),
            ),
            Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: Text('History: ' + this.history),
            )

          ],
        )),
      ),
    );
  }

  Future<String>  _getHistory() async {
    SharedPreferences localDb = await SharedPreferences.getInstance();
    String history =localDb.getString("history");
    return history;
  }

  Widget getImageAsset() {

    //AssetImage assetImage = AssetImage("/img/money.png');
    Image image = Image.network("https://www.clipartmax.com/png/middle/82-826579_banknote-united-states-dollar-money-money-vector.png"); //Image(image: assetImage, width: 125.0, height: 125.0,);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding * 10),);
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

_calculateTotalReturns(){


    double principal = double.parse(principalController.text);

    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;



    String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    setLocalStorage(result);

    return result;
  }

  setLocalStorage(String result) async {
    SharedPreferences localDb = await SharedPreferences.getInstance();
    //List<String> history =
    localDb.setString("history","Last result: "+result);

  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}