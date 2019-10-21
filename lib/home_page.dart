import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/custom_dailog.dart';
import 'package:flutter_app/game_button.dart';
import 'package:flutter_app/components/time.dart';
import 'package:flutter_app/components/dependencies.dart';
import 'package:flutter_app/components/map.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = new List();
    player2 = new List();
    activePlayer = 1;

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
      new GameButton(id: 10),
      new GameButton(id: 11),
      new GameButton(id: 12),
      new GameButton(id: 13),
      new GameButton(id: 14),
      new GameButton(id: 15),
      new GameButton(id: 16),
      new GameButton(id: 17),
      new GameButton(id: 18),
      new GameButton(id: 19),
      new GameButton(id: 20),
      new GameButton(id: 21),
      new GameButton(id: 22),
      new GameButton(id: 23),
      new GameButton(id: 24),
      new GameButton(id: 25),
      new GameButton(id: 26),
      new GameButton(id: 27),
      new GameButton(id: 28),
      new GameButton(id: 29),
      new GameButton(id: 30),
      new GameButton(id: 31),
      new GameButton(id: 32),
      new GameButton(id: 33),
      new GameButton(id: 34),
      new GameButton(id: 35),
      new GameButton(id: 36),
      new GameButton(id: 37),
      new GameButton(id: 38),
      new GameButton(id: 39),
      new GameButton(id: 40),
      new GameButton(id: 41),
      new GameButton(id: 42),
      new GameButton(id: 43),
      new GameButton(id: 54),
      new GameButton(id: 45),
      new GameButton(id: 46),
      new GameButton(id: 47),
      new GameButton(id: 48),
      new GameButton(id: 49),
      new GameButton(id: 50),
      new GameButton(id: 51),
      new GameButton(id: 52),
      new GameButton(id: 53),
      new GameButton(id: 54),
      new GameButton(id: 55),
      new GameButton(id: 56),
      new GameButton(id: 57),
      new GameButton(id: 58),
      new GameButton(id: 59),
      new GameButton(id: 60),
      new GameButton(id: 61),
      new GameButton(id: 62),
      new GameButton(id: 63),
      new GameButton(id: 64),
      new GameButton(id: 65),
      new GameButton(id: 66),
      new GameButton(id: 67),
      new GameButton(id: 68),
      new GameButton(id: 69),
      new GameButton(id: 70),
      new GameButton(id: 71),
      new GameButton(id: 72),
      new GameButton(id: 73),
      new GameButton(id: 74),
      new GameButton(id: 75),
      new GameButton(id: 76),
      new GameButton(id: 77),
      new GameButton(id: 78),
      new GameButton(id: 79),
      new GameButton(id: 80),
      new GameButton(id: 81),
      new GameButton(id: 82),
      new GameButton(id: 83),
      new GameButton(id: 84),
      new GameButton(id: 85),
      new GameButton(id: 86),
      new GameButton(id: 87),
      new GameButton(id: 88),
      new GameButton(id: 89),
      new GameButton(id: 90),
      new GameButton(id: 91),
      new GameButton(id: 92),
      new GameButton(id: 93),
      new GameButton(id: 94),
      new GameButton(id: 95),
      new GameButton(id: 96),

    ];

    return gameButtons;
  }
  

  void playGame(GameButton gb) {

    setState(() {

      if (tower >= 1) {
        gb.text = towert;
        if (tower == 1) {
          //change these colors to sprites
        gb.bg = Colors.red;
        }
        if (tower == 2) {
          gb.bg = Colors.green;
        }
        if (tower == 3) {
          gb.bg = Colors.yellow;
        }
        if (tower == 4) {
          gb.bg = Colors.blue;
        }
      }


      gb.enabled = false;
      int winner = checkWinner();

      if (winner == -1) {
        if (buttonsList.every((p) => p.text != "")) {

          showDialog(
              context: context,
              builder: (_) => new CustomDialog("Game Tied",
                  "Press the reset button to start again.", resetGame));
        } else {
          activePlayer == 2 ? autoPlay() : null;
        }
      }
    });
  }



  void autoPlay() {
    var emptyCells = new List();
    var list = new List.generate(96, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID))) {
      }
    }

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length-1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p)=> p.id == cellID);
    playGame(buttonsList[i]);

  }


  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }

      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Player 1 Won",
                "Press the reset button to start again.", resetGame));
      }
    return winner;
  }

//Sets the squares to the tower type
  String towert  = "";
  var tower =1;

  void settower1(){
    towert = "";
    tower = 1;
  }
  void settower2(){
    towert = "";
    tower = 2;
  }
  void settower3(){
    towert = "";
    tower = 3;
  }
  void settower4(){
    towert = "";
    tower = 4;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {

    buttonsList[10].bg = Colors.cyanAccent;
    buttonsList[11].bg = Colors.brown;
    buttonsList[12].bg = Colors.brown;
    buttonsList[13].bg = Colors.brown;
    buttonsList[14].bg = Colors.brown;
    buttonsList[22].bg = Colors.brown;
    buttonsList[30].bg = Colors.brown;
    buttonsList[38].bg = Colors.brown;
    buttonsList[46].bg = Colors.brown;
    buttonsList[54].bg = Colors.brown;
    buttonsList[62].bg = Colors.brown;
    buttonsList[70].bg = Colors.brown;
    buttonsList[78].bg = Colors.brown;
    buttonsList[86].bg = Colors.pink;

    make_path();

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("game test"),
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text(
                      "Timer",
                  ),
                  new Text(
                    "Score: 0",
                  ),
                  new Text(
                    "Lives: 30",
                  ),
                  new Text(
                      "Money",
                  ),
                ],
              ),
            ),

            new Expanded(
              child: new GridView.builder(
                padding: const EdgeInsets.all(2.0),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0),
                itemCount: buttonsList.length,
                itemBuilder: (context, i) => new SizedBox(
                  width: 2.0,
                  height: 2.0,
                  child: new RaisedButton(
                    padding: const EdgeInsets.all(8.0),

                    onPressed: buttonsList[i].enabled
                        ? () => playGame(buttonsList[i])
                        : null,

                    child: new Text(
                      buttonsList[i].text,
                      style: new TextStyle(
                          color: Colors.white, fontSize: 20.0),
                    ),
                    color: buttonsList[i].bg,
                    disabledColor: buttonsList[i].bg,
                  ),
                ),
              ),
            ),
            Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new RaisedButton(
                    child: new Text(
                     "Tower 1",
                      style: new TextStyle(color: Colors.white, fontSize: 10.0),
                   ),
                    color: Colors.red,
                    padding: const EdgeInsets.all(20.0),
                    onPressed: settower1,
                  ),
                  new RaisedButton(
                     child: new Text(
                       "Tower 2",
                       style: new TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                    color: Colors.green,
                    padding: const EdgeInsets.all(20.0),
                    onPressed: settower2,
                  ),
                  new RaisedButton(
                    child: new Text(
                      "Tower 3",
                      style: new TextStyle(color: Colors.white, fontSize: 10.0),
                                          ),
                    color: Colors.yellow,
                    padding: const EdgeInsets.all(20.0),
                    onPressed: settower3,
                  ),
                  new RaisedButton(
                     child: new Text(
                       "Tower 4",
                      style: new TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                    color: Colors.blue,
                    padding: const EdgeInsets.all(20.0),
                    onPressed: settower4,
                  )
                ],
              ),
            ),


          ],
        ));
  }


}