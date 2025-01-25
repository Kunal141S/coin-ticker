import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = 'e819a941-80d1-4489-8210-aae8a847a9d6';
const String url = 'https://api-apac.coinapi.io/v1/exchangerate/';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class NetWorkHelper {
  NetWorkHelper(this.url);
  final String url;
  Future getData() async {
    var response = await http.get(
      Uri.parse(url),
    );
    String data = response.body;
    var decodeData = jsonDecode(data);
    return decodeData;
  }
}

class CoinData {}

//https://api-apac.coinapi.io/v1/exchangerate/BTC/USD?apikey=e819a941-80d1-4489-8210-aae8a847a9d6
