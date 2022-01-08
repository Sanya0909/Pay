import 'dart:developer';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phone_verific/gender_button.dart';
import 'package:phone_verific/screens/home_sreen.dart';
import 'dart:async';
import 'constants.dart';

enum GenderType { male, female }

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GenderType? gender;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1956, 8),
        lastDate: DateTime(2022));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 56.0,
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: const Text(
                'Создайте профиль',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Gilroy'),
              ),
              margin: EdgeInsets.only(top: 40.0, left: 30.0),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Center(
              child: Container(
                width: 280.0,
                height: 40.0,
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Имя'),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                width: 280.0,
                height: 40.0,
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Фамилия'),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                width: 280.0,
                height: 40.0,
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () => _selectDate(context),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 175),
                    child: Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 75.0),
              child: Text('Пол'),
            ),
            const SizedBox(
              height: 17,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Center(
                    child: GenderButton(
                      colour: gender == GenderType.male
                          ? kActiveCardColour
                          : kInactiveCardColour,
                      onPress: () {
                        setState(() {
                          gender = GenderType.male;
                        });
                      },
                    ),
                  ),
                ),
                const Text(
                  'Мужчина',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Center(
                  child: GenderButton(
                    colour: gender == GenderType.female
                        ? kActiveCardColour
                        : kInactiveCardColour,
                    onPress: () {
                      setState(() {
                        gender = GenderType.female;
                      });
                    },
                  ),
                ),
                const Text(
                  'Женщина',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 43),
            Center(
              child: Container(
                  color: Colors.deepOrange,
                  width: 280,
                  height: 45,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HomeScreen();
                        }));
                      },
                      child: const Text(
                        'Создать профиль',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal),
                      ))),
            ),
          ],
        ));
  }
}
