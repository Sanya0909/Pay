import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_verific/cards_model.dart';

class TransferPayment extends StatefulWidget {
  const TransferPayment({Key? key}) : super(key: key);

  @override
  _TransferPaymentState createState() => _TransferPaymentState();
}

class _TransferPaymentState extends State<TransferPayment> {
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
              child: const Center(
                child: Text('Чек к оплате',
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
                        children: const <Widget>[
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
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 80,
                      width: 320,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 16, right: 6),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 40,
                              width: 69,
                              margin: EdgeInsets.only(right: 10),
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
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
