import 'package:mobx/mobx.dart';

part 'contador.store.g.dart';

class ContadorStore = _ContadorStore with _$ContadorStore;

abstract class _ContadorStore with Store {
  //observavel
  @observable
  int contador = 200;

  //uma ação
  //local onde altera o observable
  @action
  void increment() {
    contador++;
  }
}
