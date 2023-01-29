import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notification/screens/alet.dart';

import 'package:flutter_local_notification/screens/second_screen.dart';
import 'package:flutter_local_notification/services/local_notification_service.dart';
import 'package:torch_light/torch_light.dart';

import 'package:vibration/vibration.dart';

import '../main.dart';

class alarm extends StatefulWidget {
  const alarm({Key? key}) : super(key: key);

  @override
  State<alarm> createState() => _HomeState();
}

final myController = TextEditingController();

@override
void dispose() {
  myController.dispose();
}

class _HomeState extends State<alarm> {
  late final LocalNotificationService service;
  TextEditingController dateController = TextEditingController();
  late DateTime pickedDate;
  late TimeOfDay time;
  static AudioCache player = new AudioCache();
  final alarmAudioPath = "delete.wav";
  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alar... po co to pisze? chyba wiesz gdzie wszedłeś'),
        centerTitle: true,
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
                  const Text(
                    'Wpisz co masz tak "naprawde ważnego"... jakby kogoś to interesowało',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextField(
                    controller: myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          'Naprawde nikogo nie obchodzi co masz w planach',
                    ),
                  ),
                  ListTile(
                    title: Text(
                        "Date: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                    trailing: Icon(Icons.keyboard_arrow_down),
                    onTap: _pickDate,
                  ),
                  ListTile(
                    title: Text("Time: ${time.hour}:${time.minute}"),
                    trailing: Icon(Icons.keyboard_arrow_down),
                    onTap: _pickTime,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (DateTime.now().minute >= time.minute &&
                          DateTime.now().hour >= time.hour &&
                          DateTime.now().day >= pickedDate.day &&
                          DateTime.now().month >= pickedDate.month &&
                          DateTime.now().year >= pickedDate.year) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Nie prawidłowa data lub czas"),
                            content: const Text(
                                "Jak stworzy ktoś maszyne czasu to wtedy ... nie no nawet wtedy to nie bedzie dzialac poprostu naucz sie jak dziala zegar zeby wiedziec przynajmniej która godzina bedzie twoja ostatnia"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  color: Colors.green,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Pojołem swoje winny"),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Mozesz zacząć sie bać "),
                            content: const Text(
                                "Właśnie ustawiłeś przyponienie ... spokojnie tak życiowo ogarnieta osoba jak ty też zobaczy to przypomnienie"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  color: Colors.green,
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Pojołem swoje winny"),
                                ),
                              ),
                            ],
                          ),
                        );
                        tortch();
                        await service.showScheduledNotification(
                            id: 0,
                            title: 'Nikt cie nie kocha',
                            body:
                                'To tylko przypomnienie ze masz spotkanie na którym nikogo nie bedzie obchodziło czy bedzieszs wienc moze zostań w tej piwnicy',
                            day: pickedDate.day,
                            month: pickedDate.month,
                            year: pickedDate.year,
                            hours: time.hour,
                            min: time.minute,
                            seconds: 0,
                            payload: myController.text);
                      }
                    },
                    child: const Text(
                        'ustaw swoje przypomnienie na własną odpowiedzialnosc'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => alet(payload: payload))));
    }
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );

    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  _pickTime() async {
    TimeOfDay? t = await showTimePicker(context: context, initialTime: time);

    if (t != null)
      setState(() {
        time = t;
      });
  }

  void tortch() {
    DateTime dt1 = DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
        time.hour, time.minute, 0);
    DateTime dt2 = DateTime.now();

    Duration diff = dt1.difference(dt2);
    print(diff.inSeconds);
    Future.delayed(Duration(seconds: diff.inSeconds), () async {
      TorchLight.enableTorch();
      player.load(alarmAudioPath);
      Vibration.vibrate(duration: 1000);
    });
    ;
  }
}
