import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:math';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen(
      {Key? key,
      required this.bitcoinData,
      required this.ethereumData,
      required this.litecoinData})
      : super(key: key);
  final dynamic bitcoinData;
  final dynamic ethereumData;
  final dynamic litecoinData;

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  String exchangeRateBTC = '?';
  String exchangeRateETH = '?';
  String exchangeRateLTC = '?';
  late CoinData coinData;

  @override
  void initState() {
    super.initState();
    coinData = CoinData();
    setState(() {
      if (widget.bitcoinData == null) {
        exchangeRateBTC = '?';
        exchangeRateETH = '?';
        exchangeRateLTC = '?';
        return;
      }
      exchangeRateBTC = (widget.bitcoinData['rate'].toInt()).toString();
      exchangeRateETH = (widget.ethereumData['rate'].toInt()).toString();
      exchangeRateLTC = (widget.litecoinData['rate'].toInt()).toString();
    });
  }

  void updateUI(String currency, String cryptoCurrency, cryptoType) async {
    var cryptoData = await coinData.getCoinData(currency, cryptoCurrency);
    setState(() {
      if (cryptoData == null) {
        cryptoType = '?';
        return;
      }
      cryptoType = (cryptoData['rate'].toInt()).toString();
      selectedCurrency = currency;
    });
  }

  DropdownButton androidDropdown() {
    List<DropdownMenuItem> dropDownItems = [];
    for (String currency in currenciesList) {
      DropdownMenuItem newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) async {
        updateUI(value, 'BTC', exchangeRateBTC);
        updateUI(value, 'ETH', exchangeRateETH);
        updateUI(value, 'LTC', exchangeRateLTC);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) async {
        updateUI(currenciesList[selectedIndex], 'BTC', exchangeRateBTC);
        updateUI(currenciesList[selectedIndex], 'ETH', exchangeRateETH);
        updateUI(currenciesList[selectedIndex], 'LTC', exchangeRateLTC);
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $exchangeRateBTC $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $exchangeRateETH $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $exchangeRateLTC $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
