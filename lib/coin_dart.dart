import 'package:http/http.dart' as http;
import 'dart:convert';

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '7A6C876C-4C6B-450C-AB1F-A973365DA2A4';

class CoinData {
  Future<dynamic> getCoinData(String currency) async {
    var response = await http.get('${coinAPIURL}/BTC/$currency?apikey=$apiKey');
    print(response.statusCode);
    if (response.statusCode == 200) {
      return (jsonDecode(response.body));
    } else {
      return (response.statusCode.toString());
    }
  }
}
