import 'package:baloon_popper/manager/balloon_manager.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import '../game_components/background_component.dart';
import '../game_components/score_component.dart';

class BalloonLevel extends FlameBlocGame with HasTappables {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(BackgroundComponent());
    add(ScoreComponent());
    addAll(BalloonManager(size).baloons);
  }
}
