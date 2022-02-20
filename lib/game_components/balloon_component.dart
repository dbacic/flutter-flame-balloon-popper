import 'dart:math';

import 'package:baloon_popper/cubit/game_state_cubit.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';

import '../levels/balloon_level.dart';

// Responsible for spawning a balloon that can have a different sprite,
// movement, pop efect and sound as well as sending the event to the bloc
class BalloonComponent extends SpriteComponent
    with Tappable, HasGameRef<BalloonLevel> {
  final int _offset;
  Vector2 _gameArea = Vector2.zero();
  bool _isMoving = true;
  int _baloonNum = 0;

  BalloonComponent(this._offset)
      : super(
          size: Vector2.all(64),
          priority: 5,
        );

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
    _gameArea = gameSize;

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
    if (!_isMoving) {
      return true;
    }

    print("Baloon $hashCode popped");
    gameRef.read<GameStateCubit>().add(AddScoreGameEvent((_baloonNum + 1) * 2));
    _loadExplosion();
    return true;
  }

  void _move(double dt) {
    if (!_isMoving) {
      return;
    }

    position = Vector2(position.x, position.y - 100 * dt);

    // if ballon goes of the top
    if (position.y < -size.y) {
      _respwn();
    }
  }

  double _randomXPosition() {
    num x = Random().nextInt(_gameArea.x.toInt());
    return x.clamp(size.x / 2, _gameArea.x - size.x / 2).toDouble();
  }

  double _randomYPosition() {
    return Random().nextInt(size.y.toInt()).toDouble() * _offset * 4;
  }

  void _loadExplosion() async {
    FlameAudio.play("pop.mp3");
    sprite = await Sprite.load('explosion.png');
    _isMoving = false;

    Future.delayed(const Duration(milliseconds: 500), () async {
      _isMoving = true;
      _respwn();
    });
  }

  void _respwn() async {
    position = Vector2(_randomXPosition(), _gameArea.y + _randomYPosition());
    sprite = await Sprite.load(_getBallon());
  }

  String _getBallon() {
    _baloonNum = Random().nextInt(3);
    return "balloon-$_baloonNum.png";
  }
}
