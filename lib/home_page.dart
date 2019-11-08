import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/custom_dailog.dart';
import 'package:flutter_app/enemy.dart';
import 'package:flutter_app/game_button.dart';
import 'dart:async';
//import 'package:flutter_app/components/time.dart';
//import 'package:flutter_app/components/dependencies.dart';
//import 'package:flutter_app/components/map.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;

  Timer _timer;
  int _countDown = 120;
  int _money = 100;
  int _lives = 30;
  var _enemySpawn = [115, 107, 95, 83, 71, 59, 47, 35, 23, 11];
  var _enemyPath = [11, 12, 13, 14, 22, 30, 38, 46, 54, 62, 70, 78];
  var _enemyPathX = [170, 215, 260, 270];
  var _enemyPathY = [95, 140, 185, 230, 275, 320, 365, 410];

  Enemy enemy = new Enemy(125, 70);

  double finalX = 270;
  double finalY = 440;
  double buttonSize = 45;

  int checkDamage(Enemy enemy) {
    if (enemy.x < finalX) {
      for (int i = 0; i <= 3; i++) {
        if (enemy.x <= _enemyPathX[i]){
          if (buttonsList[_enemyPath[i] + 1].tower == true)
            enemy.health -= buttonsList[_enemyPath[i] + 1].damage;
          if (buttonsList[_enemyPath[i] - 1].tower == true)
            enemy.health -= buttonsList[_enemyPath[i] - 1].damage;
          if (buttonsList[_enemyPath[i] + 8].tower == true)
            enemy.health -= buttonsList[_enemyPath[i] + 8].damage;
          if (buttonsList[_enemyPath[i] - 8].tower == true)
            enemy.health -= buttonsList[_enemyPath[i] - 8].damage;
          break;
        }
      }
    } else if (enemy.y < finalY){
      for (int j = 0; j < 7; j++) {
        if (enemy.y <= _enemyPathY[j]) {
          if (buttonsList[_enemyPath[j + 3] + 1].tower == true)
            enemy.health -= buttonsList[_enemyPath[j + 3] + 1].damage;
          if (buttonsList[_enemyPath[j + 3] - 1].tower == true)
            enemy.health -= buttonsList[_enemyPath[j + 3] - 1].damage;
          if (buttonsList[_enemyPath[j + 3] + 8].tower == true)
            enemy.health -= buttonsList[_enemyPath[j + 3] + 8].damage;
          if (buttonsList[_enemyPath[j + 3] - 8].tower == true)
            enemy.health -= buttonsList[_enemyPath[j + 3] - 8].damage;
          break;
        }
      }
    }
  }

  // does time and enemy spawn right now
  void startTimer() {
    const duration = const Duration(seconds: 1);
    int checkSpawn = 0;
    int checkPath = 0;
    Size dimensions;

    for (int i = 0; i < 12; i++)
    {
      buttonsList[_enemyPath[i]].bg = Colors.brown;
    }
    _timer = new Timer.periodic(
      duration,
          (Timer timer) => setState(
            () {
          if (_countDown < 1) {
            timer.cancel();
          } else {
            if (_countDown == _enemySpawn[checkSpawn]) {
              if (checkSpawn != 9)
                checkSpawn++;
            }
            checkDamage(enemy);

            if (enemy.health > 0) {
              if (enemy.x <= finalX)
                enemy.x += 10;
              else if (enemy.y < finalY)
                enemy.y += 10;

              if (enemy.y == 440 && enemy.enemyColor != Colors.white.withOpacity(0.0) ) {
                _lives -= 1;
                enemy.enemyColor = Colors.white.withOpacity(0.0);
              }
            } else
              enemy.enemyColor = Colors.white.withOpacity(0.0);
            _countDown = _countDown - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    enemy.build();
    super.initState();
    buttonsList = doInit();
    startTimer();
  }

  List<GameButton> doInit() {
    player1 = new List();
    player2 = new List();
    activePlayer = 1;

    var gameButtons = <GameButton>[
      for (int i = 1; i <= 96; i++)
        new GameButton(id: i),
    ];

    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {

      if (tower >= 1 && _money >= 20) {
        gb.text = towert;
        _money -= 20;
        if (tower == 1) {
          //change these colors to sprites
          gb.bg = Colors.red;
          gb.tower = true;
          gb.damage = 15;
          gb.price = 10;
        }
        if (tower == 2) {
          gb.bg = Colors.green;
          gb.tower = true;
          gb.damage = 20;
          gb.price = 15;
        }
        if (tower == 3) {
          gb.bg = Colors.yellow;
          gb.tower = true;
          gb.damage = 20;
          gb.price = 15;
        }
        if (tower == 4) {
          gb.bg = Colors.blue;
          gb.tower = true;
          gb.damage = 15;
          gb.price = 10;
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
  var tower = 0;

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
    buttonsList[86].bg = Colors.pink;


    for (int i = 0; i < 12; i++) {
      //buttonsList[_enemyPath[i]].bg = Colors.brown;
      buttonsList[_enemyPath[i]].enabled = false;
      buttonsList[_enemyPath[i]].bg = Colors.white.withOpacity(0.0);
    }

    int score = enemy.health;

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("game test"),
        ),
        body: new Stack(


          children: <Widget> [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Center(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        "Timer: $_countDown",
                      ),
                      new Text(
                        "Score: $score",
                      ),
                      new Text(
                        "Lives: $_lives",
                      ),
                      new Text(
                        "Money: $_money",
                      ),
                    ],
                  ),
                ),

                new Expanded(
                  child: GridView.builder(
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

                        child: Image.asset(
                          "assets/images/plot.PNG",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
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
                        child: Image.asset(
                          "assets/images/tower1.png",
                          width: 30,
                          fit: BoxFit.cover,
                        ),

                        color: Colors.red,
                        padding: const EdgeInsets.all(20.0),
                        onPressed: settower1,
                      ),
                      new RaisedButton(
                        child: Image.asset(
                          "assets/images/tower1.png",
                          width: 30,
                          fit: BoxFit.cover,
                        ),

                        color: Colors.green,
                        padding: const EdgeInsets.all(20.0),
                        onPressed: settower2,
                      ),
                      new RaisedButton(
                        child: Image.asset(
                          "assets/images/tower1.png",
                          width: 30,
                          fit: BoxFit.cover,
                        ),

                        color: Colors.yellow,
                        padding: const EdgeInsets.all(20.0),
                        onPressed: settower3,
                      ),
                      new RaisedButton(
                        child: Image.asset(
                          "assets/images/tower1.png",
                          width: 30,
                          fit: BoxFit.cover,
                        ),

                        color: Colors.blue,
                        padding: const EdgeInsets.all(20.0),
                        onPressed: settower4,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(enemy.x, enemy.y),
              child: enemy.build(),
            )
          ],
        ));
  }


}
