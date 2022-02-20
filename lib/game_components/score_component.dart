import 'package:baloon_popper/cubit/game_state_cubit.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'dart:ui' hide TextStyle;

import 'package:flutter/material.dart';

const style = TextStyle(
  color: Colors.white,
  fontSize: 40,
);
final regular = TextPaint(
  style: style,
);

class ScoreComponent extends TextComponent
    with BlocComponent<GameStateCubit, GameCurrentState> {
  Vector2 gameArea = Vector2.zero();

  ScoreComponent()
      : super(
          priority: 10,
        );

  @override
  void onGameResize(Vector2 gameSize) {
    print("Game area is: $gameSize");
    super.onGameResize(gameSize);
    gameArea = gameSize;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    textRenderer = regular;
    text = "0";
    position = Vector2(gameArea.x - 50, 40);
    anchor = Anchor.center;
  }

  @override
  void onNewState(GameCurrentState state) {
    super.onNewState(state);
    text = state.score.toString();
  }
}
