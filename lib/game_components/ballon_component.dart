import 'dart:math';

import 'package:baloon_popper/cubit/game_state_cubit.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';

import '../baloon_game.dart';

class BaloonComponent extends SpriteComponent
    with Tappable, HasGameRef<BaloonGame> {
  BaloonComponent(this.offset)
      : super(
          size: Vector2.all(64),
          priority: 5,
        );
  int offset;
  Vector2 gameArea = Vector2.zero();
  bool isMoving = true;

  int baloonNum = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await FlameAudio.audioCache.load("pop.mp3");
    sprite = await Sprite.load(_getBallon());
    anchor = Anchor.center;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    print("Game area is: $gameSize");
    super.onGameResize(gameSize);
    gameArea = gameSize;

    num baloonSize =
        (gameSize.y < gameSize.x) ? gameSize.x / 8 : gameSize.y / 8;
    size = Vector2.all(baloonSize.toDouble());
    position = Vector2(_randomXPosition(), gameSize.y + _randomYPosition());
  }

  @override
  void update(double dt) {
    super.update(dt);
    _move(dt);
  }

  @override
  void onRemove() {
    super.onRemove();
    print("Ballon ${hashCode} removed from game");
  }

  @override
  bool onTapUp(TapUpInfo info) {
    if (!isMoving) {
      return true;
    }

    print("Baloon $hashCode popped");
    gameRef.read<GameStateCubit>().add(AddScoreGameEvent((baloonNum + 1) * 2));
    _loadExplosion();
    return true;
  }

  void _move(double dt) {
    if (!isMoving) {
      return;
    }

    position = Vector2(position.x, position.y - 100 * dt);

    // if ballon goes of the top
    if (position.y < -size.y) {
      // removeFromParent();
      _respwn();
    }
  }

  double _randomXPosition() {
    num x = Random().nextInt(gameArea.x.toInt());
    return x.clamp(size.x / 2, gameArea.x - size.x / 2).toDouble();
  }

  double _randomYPosition() {
    return Random().nextInt(size.y.toInt()).toDouble() * offset * 4;
  }

  void _loadExplosion() async {
    FlameAudio.play("pop.mp3");
    sprite = await Sprite.load('explosion.png');
    isMoving = false;

    Future.delayed(const Duration(milliseconds: 500), () async {
      isMoving = true;
      _respwn();
    });
  }

  void _respwn() async {
    position = Vector2(_randomXPosition(), gameArea.y + _randomYPosition());
    sprite = await Sprite.load(_getBallon());
  }

  String _getBallon() {
    baloonNum = Random().nextInt(3);
    return "baloon-$baloonNum.png";
  }
}
