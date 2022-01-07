import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_verific/profile.dart';
import 'package:phone_verific/screens/home_sreen.dart';
import 'package:phone_verific/transfer.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPControllerSreen extends StatefulWidget {
  final String phone;
  final String codeDigits;

  OTPControllerSreen({required this.phone, required this.codeDigits});

  @override
  _OTPControllerSreenState createState() => _OTPControllerSreenState();
}

class _OTPControllerSreenState extends State<OTPControllerSreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController _pinOTPCodeController = TextEditingController();

  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificationCode;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Colors.white70,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: Colors.grey),
  );

  @override
  void initState() {
    super.initState();

    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${widget.codeDigits + widget.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => Transfer()));
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ),
        );
      },
      codeSent: (String vID, int? resentToken) {
        setState(() {
          verificationCode = vID;
        });
      },
      codeAutoRetrievalTimeout: (String vID) {
        setState(() {
          verificationCode = vID;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(''),
      ),
      body: Column(
        children: [
          SizedBox(height: 56),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  verifyPhoneNumber();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: const Text(
                    "Верицикация",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Text(
              'Введите код отправленный на ваш номер',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: PinPut(
              fieldsCount: 6,
              textStyle: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
              eachFieldWidth: 60.0,
              eachFieldHeight: 60.0,
              focusNode: _pinOTPCodeFocus,
              controller: _pinOTPCodeController,
              submittedFieldDecoration: pinOTPCodeDecoration,
              selectedFieldDecoration: pinOTPCodeDecoration,
              followingFieldDecoration: pinOTPCodeDecoration,
              pinAnimationType: PinAnimationType.rotation,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: verificationCode!, smsCode: pin))
                      .then((value) {
                    if (value.user != null) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (c) => Transfer()));
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Невереный код'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
