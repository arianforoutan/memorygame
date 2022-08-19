import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memorygame/MainGame.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Initialization
  MainGame _mainGame = MainGame();
  int score = 0;
  @override
  void initState() {
    super.initState();
    _mainGame.initMainGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 238, 172, 49),
              Color.fromARGB(255, 212, 72, 53),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 100, right: 100, top: 15, bottom: 20),
                child: resultGame('Score', '$score'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    itemCount: _mainGame.GameImage!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 6,
                        crossAxisCount: 4,
                        mainAxisSpacing: 10),
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          print(_mainGame.matchCheck);
                          setState(() {
                            _mainGame.GameImage![index] =
                                _mainGame.cards_list[index];
                            _mainGame.matchCheck
                                .add({index: _mainGame.cards_list[index]});
                          });
                          if (_mainGame.matchCheck.length == 2) {
                            if (_mainGame.matchCheck[0].values.first ==
                                _mainGame.matchCheck[1].values.first) {
                              score += 100; //Each correct choice has 100 points
                              _mainGame.matchCheck
                                  .clear(); //To continue the command in the next clicks
                            } else {
                              Future.delayed(Duration(milliseconds: 250), () {
                                print(_mainGame.GameImage);
                                setState(() {
                                  _mainGame.GameImage![_mainGame.matchCheck[0]
                                      .keys.first] = _mainGame.hiddenImages;
                                  _mainGame.GameImage![_mainGame.matchCheck[1]
                                      .keys.first] = _mainGame.hiddenImages;
                                  _mainGame.matchCheck
                                      .clear(); //To continue the command in the next clicks
                                });
                              });
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(_mainGame.GameImage![index]),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                  ),
                  onPressed: (() {
                    //for refresh page
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  }),
                  child: Text(
                    'refresh',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget resultGame(String title, String result) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.amber),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            result,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
