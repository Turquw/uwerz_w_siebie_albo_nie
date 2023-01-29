import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, QuerySnapshot;
import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:intl/date_symbols.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({
    Key? key,
    required this.payload,
    required this.question,
    required this.odpowiedz,
  }) : super(key: key);
  final String payload;
  final String question;
  final String odpowiedz;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String, HighlightedWord> _highlights = {};

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  String? _kot;
  String? _pies;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Teraz masz przegwizdane'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: _listen,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                    child: SizedBox(
                  height: 500,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Visibility(
                          child: Text(demo().toString()),
                          visible: false,
                        ),
                        Text(_kot!),
                        TextHighlight(
                          text: _text,
                          words: _highlights,
                          textStyle: const TextStyle(
                            fontSize: 32.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        FloatingActionButton(
                          child: Icon(Icons.autorenew),
                          onPressed: () {
                            demo();
                          },
                          heroTag: null,
                        )
                      ]),
                )))));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (_text == _pies) {
              player.stop();
              TorchLight.disableTorch();
            }
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void test() {
    if (_text == "halo") {
      player.stop();
    }
  }

  Future<String> demo() async {
    QuerySnapshot myCollection1;

    print("huj");

    myCollection1 =
        await FirebaseFirestore.instance.collection('Zagadki').get();
    print(myCollection1.docs.length);
    final String Pytanie = myCollection1.docs[0]['pytanie'];
    final String Odpowiedz = myCollection1.docs[0]['odpowiedz'];
    _kot = Pytanie;
    _pies = Odpowiedz;
    print(_kot);
    print(_pies);
    return "";
  }
}
