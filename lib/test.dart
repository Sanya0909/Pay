import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_verific/constants.dart';
import 'package:phone_verific/OTP.dart';
import 'profile.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String dialCodeDigits = "+998";
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/logo Dartpay horizontal 1.png'),
                )),
                width: 120.0,
                margin: EdgeInsets.only(top: 67.0),
                height: 148.0,
              ),
            ),
            const Text(
              'Введите ваш номер телефона',
              style: kIntroductionScreenStyle2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: CountryCodePicker(
                onChanged: (country) {
                  setState(() {
                    dialCodeDigits = country.dialCode!;
                  });
                },
                initialSelection: "UZ",
                showCountryOnly: true,
                favorite: const ['UZ'],
                showOnlyCountryWhenClosed: false,
              ),
            ),
            Center(
              child: Container(
                width: 280,
                height: 80,
                margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "",
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(dialCodeDigits),
                    ),
                  ),
                  maxLength: 9,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.deepOrange,
              margin: EdgeInsets.all(15),
              width: 280,
              height: 45,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => OTPControllerSreen(
                            phone: _controller.text,
                            codeDigits: dialCodeDigits,
                          )));
                },
                child: const Text(
                  'Продолжить',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Text(
              'Авторизуясь, Вы соглашаетесь с',
              style: kIntroductionScreenStyle2,
            ),
            InkWell(
              child: const Text(
                'Публичной офертой',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    fontFamily: 'Gilroy-Regular'),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
