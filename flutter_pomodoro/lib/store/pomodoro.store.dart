import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo { trabalho, descanso }

abstract class _PomodoroStore with Store {
  @observable
  bool iniciado = false;

  @observable
  int minutos = 2;

  @observable
  int segundos = 0;

  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.trabalho;

  @action
  void incrementarTempoTrabalho() {
    tempoTrabalho++;
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoTrabalho() {
    tempoTrabalho--;
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void incrementarTempoDescanso() {
    tempoDescanso++;
    if (estaDescansando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoDescanso() {
    tempoDescanso--;
    if (estaDescansando()) {
      reiniciar();
    }
  }

  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (minutos == 0 && segundos == 0) {
          _trocarTipoIntervalo();
        } else if (segundos == 0) {
          segundos = 59;
          minutos--;
        } else {
          segundos--;
        }
      },
    );
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();
    minutos = estaTrabalhando() ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  Timer? cronometro;

  bool estaTrabalhando() => tipoIntervalo == TipoIntervalo.trabalho;

  bool estaDescansando() => tipoIntervalo == TipoIntervalo.descanso;

  void _trocarTipoIntervalo() {
    if (estaTrabalhando()) {
      tipoIntervalo = TipoIntervalo.descanso;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.trabalho;
      minutos = tempoTrabalho;
    }
    //nunca vai mudar a quantidade segundos
    //apenas de minuto em minuto
    segundos = 0;
  }
}
