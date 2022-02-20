import 'package:baloon_popper/game_components/balloon_component.dart';
import 'package:flame/components.dart';

class BalloonManager {
  final List<BalloonComponent> baloons = <BalloonComponent>[];

  BalloonManager(Vector2 gameSize) {
    final baloonSize = gameSize.y / 8;
    final fitMax = (gameSize.x / baloonSize);

    // adding 3 waves of balloons with different offset so they don't
    // overlap with each other (note to self, should've be done better)
    for (var i = 0; i < fitMax; i++) {
      baloons.add(BalloonComponent(1));
    }
    for (var i = 0; i < fitMax; i++) {
      baloons.add(BalloonComponent(2));
    }
    for (var i = 0; i < fitMax; i++) {
      baloons.add(BalloonComponent(3));
    }
  }
}
