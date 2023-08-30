// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'coin_data.dart';
// class PriceScreen extends StatefulWidget {
//   @override
//   _PriceScreenState createState() => _PriceScreenState();
// }
//
// class _PriceScreenState extends State<PriceScreen> {
//   String selectedCurrency='USD';
//   List<DropdownMenuItem>getDropdownItems() {
//     List<DropdownMenuItem<String>> dropdownItems =[];
//
//     for(int i=0;i<currenciesList.length; i++) {
//
//       String currency =currenciesList[i];
//
//       var  newItem = DropdownMenuItem(
//         child: Text(currency),
//         value: currency,
//       );
//       dropdownItems.add(newItem);
//     }
//     return dropdownItems;
//   }
//   List<Text> getPickerItems(){
//     List<Text> pickerItems =[];
//     for( String currency in currenciesList){
//       pickerItems.add(Text(currency));
//     }
//     return pickerItems;
//   }
//   // String selectedCurrency='USD';
//   @override
//   Widget build(BuildContext context) {
//
//     getDropdownItems();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Center(child: Text('🤑 Coin Ticker')),
//       ),
//       body: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//
//         children: <Widget>[
//           Padding(
//              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
//             child: Card(
//               color: Colors.lightBlueAccent,
//                elevation: 5.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//                 child: Text(
//                   '1 BTC = ? USD',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
//             child: Card(
//               color: Colors.lightBlueAccent,
//               elevation: 5.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//                 child: Text(
//                   '1 ETH = ? USD',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
//             child: Card(
//               color: Colors.lightBlueAccent,
//               elevation: 5.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//                 child: Text(
//                   '1 LTC = ? USD',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: 150.0,
//             alignment: Alignment.center,
//             padding: EdgeInsets.only(bottom: 30.0),
//             color: Colors.lightBlue,
//             child:CupertinoPicker(
//               backgroundColor: Colors.lightBlue,
//               itemExtent: 32.0,
//               onSelectedItemChanged: (selectedIndex){
//                 print('selectedIndex');
//               },
//               children: getPickerItems(),
//             ),
//             // children: [
//             //   Text('USD'),
//             //   Text('EUR'),
//             //   Text('GBP'),
//             //
//             // ],)
//             // child: DropdownButton(
//             // value: selectedCurrency,
//             // items: getDropdownItems(),
//             // onChanged: (value){
//             //      setState(() {
//             //       selectedCurrency= value!;
//             //          });
//             //      }),
//             //   items: [
//             //       DropdownMenuItem(
//             //        child: Text('USD'),
//             //        value: 'USD',
//             //      ),
//             //     DropdownMenuItem(
//             //       child: Text('EUR'),
//             //       value: 'EUR',
//             //     ),
//             //     DropdownMenuItem(
//             //       child: Text('GBP'),
//             //       value: 'GBP',
//             //     ),
//             // ],
//
//           ),
//         ],
//       ),
//     );
//   }
// }






// import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
// import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  // CupertinoPicker iOSPicker() {
  //   List<Text> pickerItems = [];
  //   for (String currency in currenciesList) {
  //     pickerItems.add(Text(currency));
  //   }
  //
  //   return CupertinoPicker(
  //     backgroundColor: Colors.lightBlue,
  //     itemExtent: 32.0,
  //     onSelectedItemChanged: (selectedIndex) {
  //       setState(() {
  //         selectedCurrency = currenciesList[selectedIndex];
  //         getData();
  //       });
  //     },
  //     children: pickerItems,
  //   );
  // }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          selectedCurrency: selectedCurrency,
          value: isWaiting || coinValues[crypto] == null ? '?' : coinValues[crypto]!,
          // value: isWaiting ? '?' : coinValues[crypto],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:  androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
