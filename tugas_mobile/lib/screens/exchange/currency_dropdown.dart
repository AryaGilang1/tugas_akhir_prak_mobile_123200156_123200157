import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyExchangePage extends StatefulWidget {
  @override
  _CurrencyExchangePageState createState() => _CurrencyExchangePageState();
}

class _CurrencyExchangePageState extends State<CurrencyExchangePage> {
  String selectedFromCurrency = 'USD';
  String selectedToCurrency = 'EUR';
  double exchangeRate = 0.0;
  double amount = 0.0;
  String convertedAmount = '';

  List<String> currencies = ['USD', 'EUR', 'JPY', 'IDR', 'AUD', 'CAD'];

  void fetchExchangeRate() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.exchangerate-api.com/v4/latest/$selectedFromCurrency'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          exchangeRate = data['rates'][selectedToCurrency];
        });
      } else {
        print('Failed to fetch exchange rate');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void convertCurrency() {
    setState(() {
      convertedAmount = (amount * exchangeRate).toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Exchange Rate: 1 $selectedFromCurrency = $exchangeRate $selectedToCurrency',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: selectedFromCurrency,
                  onChanged: (value) {
                    setState(() {
                      selectedFromCurrency = value!;
                      fetchExchangeRate();
                    });
                  },
                  items:
                      currencies.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: DropdownButton<String>(
                  value: selectedToCurrency,
                  onChanged: (value) {
                    setState(() {
                      selectedToCurrency = value!;
                      fetchExchangeRate();
                    });
                  },
                  items:
                      currencies.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              fillColor: Colors.amber,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              labelText: 'Amount',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                amount = double.parse(value);
              });
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: convertCurrency,
            child: Text('Convert'),
          ),
          SizedBox(height: 16.0),
          Text(
            'Converted Amount: $convertedAmount $selectedToCurrency',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
