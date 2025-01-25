import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:convert';



const String apiKey = 'e819a941-80d1-4489-8210-aae8a847a9d6';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var currentCurrency = currenciesList[0];
  var currentCryptoCurrency = cryptoList[0];
  var currentRate;

  List<DropdownMenuItem> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  List<Widget> getCryptoPickerItems() {
    List<Widget> pickerItems = [];
    for (String crypto in cryptoList) {
      pickerItems.add(Text(crypto));
    }
    return pickerItems;
  }

  List<Widget> getCurrencyPickerItems() {
    List<Widget> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return pickerItems;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  getPrice();
  }

  Future<dynamic> getPrice() async {
    NetWorkHelper netWorkHelper = NetWorkHelper('https://api-apac.coinapi.io/v1/exchangerate/$currentCryptoCurrency/$currentCurrency?apikey=$apiKey');
    var coinData =
        await netWorkHelper.getData();
    var coinPrice = coinData['rate'];
    setState(() {
      currentRate = coinPrice.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('🤑 Coin Ticker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $currentCryptoCurrency = $currentRate $currentCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: CupertinoPicker(
                  itemExtent: 32,
                  backgroundColor: Colors.lightBlue,
                  onSelectedItemChanged: (selectedIndex) {
                    setState(
                      () {
                        currentCryptoCurrency = cryptoList[selectedIndex];
                        getPrice();
                      },
                    );
                  },
                  children: getCryptoPickerItems(),
                ),
              ),
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: CupertinoPicker(
                  itemExtent: 32,
                  backgroundColor: Colors.lightBlue,
                  onSelectedItemChanged: (selectedIndex) {
                    setState(
                      () {
                        currentCurrency = currenciesList[selectedIndex];
                        getPrice();
                      },
                    );
                  },
                  children: getCurrencyPickerItems(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Container(
// height: 150.0,
// alignment: Alignment.center,
// padding: EdgeInsets.only(bottom: 30.0),
// color: Colors.lightBlue,
// child: CupertinoPicker(
// itemExtent: 32,
// backgroundColor: Colors.lightBlue,
// onSelectedItemChanged: (selectedIndex) {
// setState(() {
// currentCurrency = currenciesList[selectedIndex];
// });
// },
// children: getPickerItems(),
// ),
// ),
