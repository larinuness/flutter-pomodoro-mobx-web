import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../store/pomodoro.store.dart';

import '../components/cronometro.dart';
import '../components/entrada_tempo.dart';
import 'package:provider/provider.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Pomodoro'),
          backgroundColor:
              store.estaTrabalhando() ? Colors.redAccent : Colors.green,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              child: Cronometro(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              //observa a mudança no valores de inc e dec
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EntradaTempo(
                      valor: store.tempoTrabalho,
                      titulo: 'Trabalho',
                      inc: store.iniciado && store.estaTrabalhando()
                          ? null
                          : store.incrementarTempoTrabalho,
                      dec: store.iniciado && store.estaTrabalhando()
                          ? null
                          : store.decrementarTempoTrabalho),
                  EntradaTempo(
                      valor: store.tempoDescanso,
                      titulo: 'Descanso',
                      inc: store.iniciado && store.estaDescansando()
                          ? null
                          : store.incrementarTempoDescanso,
                      dec: store.iniciado && store.estaDescansando()
                          ? null
                          : store.decrementarTempoDescanso),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
