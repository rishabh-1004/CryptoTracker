import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_dart.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  double rate = 0.0;
  List<String> rateChart = ['?', '?', '?'];

  DropdownButton<String> menuItemsAndroid() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text('$currency'),
        value: '$currency',
      );
      menuItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: menuItems,
      elevation: 5,
      dropdownColor: Colors.lightBlue,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          networkCall();
        });
      },
    );
  }

  CupertinoPicker iosDropDown() {
    List<Widget> menuItems = [];
    for (String currency in currenciesList) {
      menuItems.add(Text('$currency'));
    }

    return CupertinoPicker(
      itemExtent: 25.0,
      children: menuItems,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          networkCall();
        });
      },
    );
  }

  networkCall() async {
    CoinData coins = CoinData();
    var response = await coins.getallCryptoData(selectedCurrency);
    setState(() {
      rateChart[0] = response[0];
      rateChart[1] = response[1];
      rateChart[2] = response[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Tracker"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Center(
                  child: Text(
                    '1 BTC = ${rateChart[0]} $selectedCurrency',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Center(
                  child: Text(
                    '1 ETH = ${rateChart[1]} $selectedCurrency',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Center(
                  child: Text(
                    '1 LTC = ${rateChart[2]} $selectedCurrency',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: Center(
                child: Platform.isIOS ? iosDropDown() : menuItemsAndroid()),
          ),
        ],
      ),
    );
  }
}
