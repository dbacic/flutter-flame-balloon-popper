import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../levels/balloon_level.dart';
import '../cubit/game_state_cubit.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GameStateCubit(),
      child: SafeArea(
        child: GameWidget(
          game: BalloonLevel(),
        ),
      ),
    );
  }
}
