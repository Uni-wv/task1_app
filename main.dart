import 'package:audioplayers/audio_cache.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chewie/chewie.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: AudioServiceWidget(child: FirstRoute()),
    debugShowCheckedModeBanner: false,
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fraîche'),
        backgroundColor: Colors.orange.shade300,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.orange.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Card(
                color: Colors.deepOrangeAccent.shade200,
                child: Text(
                  "Welcome!",
                  style: TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                    fontStyle: FontStyle.italic,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange.shade300,
                  border: Border.all(
                    color: Colors.yellowAccent.shade100,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: RaisedButton(
                        child: Text('Music'),
                        color: Colors.blue.shade200,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondRoute()),
                          );
                        },
                      ),
                    ),
                    RaisedButton(
                      child: Text('Videos'),
                      color: Colors.lightBlueAccent.shade400,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ThirdRoute()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AudioPlayer newPlayer = new AudioPlayer();
AudioCache audio = new AudioCache(fixedPlayer: newPlayer);

bool play;
bool stop;

playAudio() {
  if (play == false || stop == true) {
    audio.play("audio/flute.mp3");
    play = true;
    stop = false;
  }
}

pauseAudio() {
  if (play == true) {
    newPlayer.pause();
    play = false;
  }
}

stopAudio() {
  if (play == true && stop == false) {
    newPlayer.stop();
    play = false;
    stop = true;
  }
}

myflute() {
  var audio = AudioCache();
  audio.play('assets/flute.mp3');
}

myImage() {
  var img = Image.asset("image/flute.jpg");
  return img;
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 400,
                height: 400,
                child: myImage(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: FlatButton(
                      onPressed: playAudio,
                      child: Icon(
                        Icons.play_arrow,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: FlatButton(
                      onPressed: pauseAudio,
                      child: Icon(Icons.pause),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: FlatButton(
                      onPressed: stopAudio,
                      child: Icon(
                        Icons.stop,
                      ),
                    ),
                  )
                ],
              ),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.brown,
                  child: Text(
                    "back!",
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void onPlayAudio() async {
  AssetsAudioPlayer.newPlayer().open(
    Audio("/assets/piano.mp3"),
    showNotification: true,
  );
}

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("video"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: <Widget>[
          ListView(
            children: [
              Column(
                children: <Widget>[
                  ChewieListItem(
                    videoPlayerController: VideoPlayerController.network(
                      'https://github.com/Uni-wv/task1_app/raw/master/Sunset.mp4',
                    ),
                    looping: true,
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.brown,
              child: Text(
                'back!',
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
