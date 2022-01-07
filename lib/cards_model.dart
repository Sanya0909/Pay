import 'package:flutter/material.dart';
import 'package:phone_verific/constants.dart';

class CardModel {
  String name;
  String cardType;
  String cardNumber;

  CardModel(this.name, this.cardType, this.cardNumber);
}

List<CardModel> cards = cardData
    .map((item) => CardModel(item['name'].toString(),
        item['cardType'].toString(), item['cardNumber'].toString()))
    .toList();

var cardData = [
  {
    "name": "Название карты",
    "cardType": "images/logo1.png",
    "cardNumber": "8600 **** **** 0000",
  },
  {
    "name": "Название карты",
    "cardType": "images/Uzcard_Logo_ 1.png",
    "cardNumber": "8600 **** **** 0000",
  }
];
