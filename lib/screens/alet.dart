import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class alet extends StatelessWidget {
  const alet({
    Key? key,
    required this.payload,
  }) : super(key: key);

  final String payload;

  @override
  Widget build(BuildContext context) {
    tortch_off();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mnie to nie interesuje ale ciebie moze tak '),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          payload,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  void tortch_off() {
    TorchLight.disableTorch();
  }
}
