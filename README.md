# Flutter 2D game with Flame

A 2D balloon popper game made with Flame that can be run on any platform supported by Flutter, it's lightweight and performant.

## Run

In order to run the game you need to:
1. Clone this repo and open it in Android Studio or VS Code
2. Open pubspec.yaml and click Ctrl+S (windows) or Cmd+S (macOS) to download the dependencies
3. Open main.dart, select a device and click F5
4. Enjoy

### Modify theme

In order to style the game as you wish, you will need to go to the **assets/images** folder and change the balloon sprites and background. Keep in mind that if you change the number of balloon sprites taht you also need to go to *balloon_component.dart* and on line 108 change the number from 3 to the number of different sprites that you added. If you feel really fancy you can also replace the explosion with [animated sprites](https://docs.flame-engine.org/1.0.0/images.html#animation) 

You can also customize the background music and pop sound by going to the **assets/audio** folder and replacing the mp3 files with something you like.
