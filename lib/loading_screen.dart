import 'package:bitcoin_ticker/price_screen.dart';

import 'coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getCryptoData();
  }

  void getCryptoData() async {
    var bitcoinData = await CoinData().getCoinData(currenciesList[0], 'BTC');
    var ethereumData = await CoinData().getCoinData(currenciesList[0], 'ETH');
    var litecoinData = await CoinData().getCoinData(currenciesList[0], 'LTC');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PriceScreen(
              bitcoinData: bitcoinData,
              ethereumData: ethereumData,
              litecoinData: litecoinData);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}
