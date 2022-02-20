import 'package:baloon_popper/game_components/ballon_component.dart';
import 'package:flame/components.dart';

class BaloonManager {
  Vector2 gameSize;
  final List<BaloonComponent> baloons = <BaloonComponent>[];

  BaloonManager(this.gameSize) {
    final baloonSize = gameSize.y / 8;
    final fitMax = (gameSize.x / baloonSize);

    for (var i = 0; i < fitMax; i++) {
      baloons.add(BaloonComponent(1));
    }
    for (var i = 0; i < fitMax; i++) {
      baloons.add(BaloonComponent(2));
    }
    for (var i = 0; i < fitMax; i++) {
      baloons.add(BaloonComponent(3));
    }
  }
}
