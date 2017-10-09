library com.jfixby.scarabei.api.util;

abstract class StateSwitcher<T> {

  void expectState(T expected_state);

  void doesNotExpectState(T unexpected_state);

  String switchState(T next_state);

  T currentState();

  void setDebugName(String string);

  void setDebugFlag(bool b);


  bool stateIs(T state);
}
