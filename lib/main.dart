import 'package:flutter/material.dart';

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

  var _currencies = ['JMD', 'USD', 'Pounds'];
  final double  _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
//			resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),

      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[

            getImageAsset(),

            Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
                  keyboardType: TextInputType.number,
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
                child: TextField(
                  keyboardType: TextInputType.number,
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

                    Expanded(child: TextField(
                      keyboardType: TextInputType.number,
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
                      }).toList(),

                      value: 'JMD',

                      onChanged: (String newValueSelected) {
                        // Your code to execute, when a menu item is selected from dropdown
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

                      },
                    ),
                  ),

                  Expanded(
                    child: RaisedButton(
                      child: Text('Reset'),
                      onPressed: () {

                      },
                    ),
                  ),

                ],)),

            Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: Text('Todo Text'),
            )

          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {

    //AssetImage assetImage = NetworkImage("https://www.clipartmax.com/png/middle/82-826579_banknote-united-states-dollar-money-money-vector.png"); // AssetImage('https://www.clipartmax.com/png/middle/82-826579_banknote-united-states-dollar-money-money-vector.png');
    Image image = Image.network("https://www.clipartmax.com/png/middle/82-826579_banknote-united-states-dollar-money-money-vector.png"); //Image(image: assetImage, width: 125.0, height: 125.0,);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding * 10),);
  }
}