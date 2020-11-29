import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:snake/main.dart';

class Logic {
  var indexes = [];
  var random = Random();
  int food = -1;
  Timer timer;
  var direction = "right";
  Widget homePage;
  VoidCallback callback;

  /*Logic(this.callback){

  }*/

  int generateFood() {
    int number = random.nextInt(150);
    while (indexes.contains(number)) {
      number = random.nextInt(150);
    }
    return number;
  }

  void startGame() {
    timer.cancel();
    direction = "right";

    indexes = [50, 51, 52];
    food = generateFood();
  }

  void foodIsEaten() {
    if (indexes[indexes.length - 1] == food) {
      food = generateFood();
    }
  }

  MaterialColor color(int index) {
    for (int i = 0; i < indexes.length; i++) {
      if (index == indexes[i]) {
        return Colors.green;
      }
    }
    if (index == food) {
      return Colors.red;
    }
    return Colors.grey;
  }

  int headPosition() {
    if (direction == "down") {
      if (indexes[indexes.length - 1] >= 140) {
        return indexes[indexes.length - 1] - 140;
      } else {
        return indexes[indexes.length - 1] + 10;
      }
    }
    if (direction == "up") {
      if (indexes[indexes.length - 1] <= 9) {
        return indexes[indexes.length - 1] + 140;
      } else {
        return indexes[indexes.length - 1] - 10;
      }
    }
    if (direction == "right") {
      if ((indexes[indexes.length - 1] - 9) % 10 == 0) {
        return indexes[indexes.length - 1] - 9;
      }
      return indexes[indexes.length - 1] + 1;
    }
    if (direction == "left") {
      if (indexes[indexes.length - 1] % 10 == 0) {
        return indexes[indexes.length - 1] + 9;
      }
      return indexes[indexes.length - 1] - 1;
    }
    return 0;
  }

  void finishGame() {
    var h = headPosition();
    for (int i = 0; i < indexes.length - 2; i++) {
      if (h == indexes[i]) {
        timer.cancel();
      }
    }
  }

  void moveSnake() {
    foodIsEaten();
    finishGame();
    var head = headPosition();
    if (head == food) {
      indexes.add(head);
    } else {
      for (int i = 0; i < indexes.length - 1; i++) {
        indexes[i] = indexes[i + 1];
      }
      indexes[indexes.length - 1] = head;
    }
  }

  void changeDirection(var d) {
    if (d == "left" && direction != "right") {
      direction = d;
    }
    if (d == "right" && direction != "left") {
      direction = d;
    }
    if (d == "up" && direction != "down") {
      direction = d;
    }
    if (d == "down" && direction != "up") {
      direction = d;
    }
  }

  String getDirection() {
    return direction;
  }
}
