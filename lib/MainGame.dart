import 'dart:math';

class MainGame {
  List<String>? GameImage;
  final String hiddenImages = "images/8888.png";
  List<String> cards_list = [
    "images/2.png",
    "images/4.png",
    "images/1.png",
    "images/3.png",
    "images/6.png",
    "images/5.png",
    "images/6.png",
    "images/5.png",
    "images/3.png",
    "images/4.png",
    "images/2.png",
    "images/1.png",
    "images/8.png",
    "images/7.png",
    "images/8.png",
    "images/7.png",
  ];

  final int cardCount = 16;
  List<Map<int, String>> matchCheck = [];

  void initMainGame() {
    cards_list.shuffle(); //make random sort list
    GameImage = List.generate(cardCount, (index) => hiddenImages);
  }
}
