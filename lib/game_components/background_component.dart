import 'package:audioplayers/src/audioplayer.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

// Responsible for loading the backgroundimage and looping the background music
class BackgroundComponent extends SpriteComponent {
  AudioPlayer? audioPlayer;

  BackgroundComponent() : super(priority: 1);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    audioPlayer = await FlameAudio.loop("background.mp3", volume: 0.1);
    sprite = await Sprite.load(
      'background.jpg',
      srcPosition: Vector2.zero(),
    );
  }

  @override
  void onGameResize(Vector2 gameSize) async {
    super.onGameResize(gameSize);
    size = gameSize;
  }

  @override
  void onRemove() {
    super.onRemove();
    audioPlayer?.pause();
    audioPlayer?.dispose();
  }
}
