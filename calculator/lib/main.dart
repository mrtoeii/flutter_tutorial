import 'package:flutter/material.dart';
void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simpke Interest Calculator App',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
    )
  );
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees','Dollars','Pounds'];
  final _minimumPadding = 5.0;
  var _currentItemSelected = '';
  void  initState(){
    super.initState();
    _currentItemSelected=_currencies[0];
  }
  TextEditingController prinicipalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '';
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding*2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: prinicipalController,
                validator: (String value){
                  if(value.isEmpty){
                    return 'Please enter principal amount';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter Principal e.g. 120000',
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15.0
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  validator: (String value){
                  if(value.isEmpty){
                    return 'Please enter rate of interest';
                  }
                },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'In percent',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: termController,
                        validator: (String value){
                          if(value.isEmpty){
                            return 'Please enter time';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Term',
                            hintText: 'Time in years',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )
                        ),
                      )
                    ),
                    Container(width: _minimumPadding*5,),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValueSelected){
                          _onDropDownItemSelected(newValueSelected);
                        },
                      )
                    )
                  ],
                ),
              ),
              Padding(
                padding:EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text('Calculate',textScaleFactor: 1.5,),
                          onPressed: (){
                            setState(() {
                              if(_formKey.currentState.validate()) {
                                this.displayResult = _calculateTotalReturns();
                              }
                            });
                          },
                        )
                    ),
                    Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text('Reset',textScaleFactor: 1.5,),
                          onPressed: (){
                            setState(() {
                              _reset();
                            });
                          },
                        )
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(_minimumPadding*2),
                  child: Text(this.displayResult,style: textStyle),

              )
            ],
          ),
        ),
      ),
    );
  }
  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('images/bank.png');
    Image image = Image(image: assetImage, width: 125.0,height: 125.0,);
    return Container(child: image,margin: EdgeInsets.all(_minimumPadding*10),);
  }
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected  = newValueSelected;
    });
  }
  String _calculateTotalReturns(){
      double principal = double.parse(prinicipalController.text);
      double roi = double.parse(roiController.text);
      double term = double.parse(termController.text);

      double totalAmountPayable = principal+(principal*roi*term)/100;

      String result = 'Alter $term years, your investmen will be worth $totalAmountPayable $_currentItemSelected';
      return result;
  }
  void _reset(){
    prinicipalController.text='';
    roiController.text='';
    termController.text='';
    displayResult='';
    _currentItemSelected= _currencies[0];
  }
}

