import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_verific/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cards_model.dart';
import 'dart:async';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.deepOrange,
              child: Center(
                child: const Text('Перевод',
                    style: TextStyle(
                        color: Color(0xFF535461),
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 59),
                    Padding(
                      padding: const EdgeInsets.only(right: 300, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'С карты',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 80,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 16, right: 6),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    child: Text(
                                      cards[index].name,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                    top: 12,
                                    right: 139,
                                    left: 35,
                                    bottom: 45,
                                  ),
                                  Positioned(
                                    child: Text(
                                      cards[index].cardNumber,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    ),
                                    top: 43,
                                    right: 111,
                                    left: 20,
                                    bottom: 12,
                                  ),
                                  Positioned(
                                    child: Image.asset('images/logo1.png'),
                                    top: 19,
                                    right: 21,
                                    left: 237,
                                    bottom: 27,
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(right: 110, bottom: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 180),
                            child: const Text(
                              'На карту',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 250,
                            height: 70,
                            child: TextFormField(
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                CardNumberInputFormatter(),
                                LengthLimitingTextInputFormatter(22),
                              ],
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 260),
                      child: Text('К отправке'),
                    ),
                    SizedBox(height: 9),
                    Padding(
                      padding: const EdgeInsets.only(right: 78),
                      child: Container(
                          width: 280,
                          height: 80,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Сумма'),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Text('К получению'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 78),
                      child: Container(
                          width: 280,
                          height: 80,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Сумма'),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 210),
                      child: Text(
                        'По курсу 1 ₽ = 145,78 сум',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepOrange,
                        ),
                        width: 330,
                        height: 50,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Продолжить',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ),
                  ],
                ),
              ))
        ]));
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class FlutterCardIo {
  static const MethodChannel _channel = const MethodChannel('flutter_card_io');

  static Future<dynamic> scanCard(Map<String, dynamic> args) {
    return _channel.invokeMethod('scanCard', args);
  }
}
