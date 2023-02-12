import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class StackedVideoView extends StatelessWidget {
  const StackedVideoView({required this.url});

  final String url;

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

          child: SizedBox(
            height: model.videoPlayerController.value.size?.height ?? 0,
            width: model.videoPlayerController.value.size?.width ?? 0,
            child: VideoPlayer(model.videoPlayerController),
          ),
          
        );
      },
    );
  }
}

class StackedVideoViewModel extends BaseViewModel {

  VideoPlayerController videoPlayerController = VideoPlayerController.network("http://localhost");

  void initialize(String videoUrl) {
    videoPlayerController = VideoPlayerController.network(videoUrl) ;
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