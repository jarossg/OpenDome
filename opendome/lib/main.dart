import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenDome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StackedVideoView(),
    );
  }
}

class StackedVideoView extends StatelessWidget {
  final String title;

  void playVideo(){
    videoPlayerController.play();
    notifyListeners();
  }

  void pauseVideo(){
    videoPlayerController.pause();
    notifyListeners();
  }

  
  @override
  Widget build(BuildContext context){
    return ViewModelBuilder<StackedVideoViewModel>.reactive(
      viewModelBuilder: () => StackedVideoViewModel(),
      onModelReady: (model) {
        model.initialize('http://192.168.1.254:8192');
      },
      builder: (context, model, child){
        return FittedBox(
          fit: BoxFit.cover,

          child GestureDetector(
            onTap: () =>
            model.videoPlayerController.value.isPlaying
                ? model.pauseVideo()
                : model.playVideo(),
          
            
            child: SizedBox(
              height: model.videoPlayerController.value.size?.height ?? 0,
              width: model.videoPlayerController.value.size?.width ?? 0,
              child: VideoPlayer(model.videoPlayerController),
            ),
          ),
        );
      },
    );
  }
}

class StackedVideoViewModel extends BaseViewModel {

  VideoPlayerController videoPlayerController;

  void initialize(String videoUrl) {
    videoPlayerController = VideoPlayerController.network(videoUrl);
    videoPlayerController.initialize().then((value) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
