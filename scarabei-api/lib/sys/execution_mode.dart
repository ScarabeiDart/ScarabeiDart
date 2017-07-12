class ExecutionMode {
  static const EARLY_DEVELOPMENT = const ExecutionMode._(3000);
  static const TESTING = const ExecutionMode._(2000);
  static const RELEASE_CANDIDATE = const ExecutionMode._(1000);
  static const DEMO = const ExecutionMode._(500);
  static const PUBLIC_RELEASE = const ExecutionMode._(0);


  static get values => [EARLY_DEVELOPMENT, TESTING, RELEASE_CANDIDATE, DEMO, PUBLIC_RELEASE];

  final int value;

  const ExecutionMode._(this.value);

  bool covers(ExecutionMode targetMode) => this.value >= targetMode.value;
}

//enum ExecutionMode {
//  EARLY_DEVELOPMENT(3000), //
//TESTING(2000), //
//RELEASE_CANDIDATE(1000), //
//DEMO(500), //
//PUBLIC_RELEASE(0);//
//
//final int level;
//
//ExecutionMode (int level) {
//  this.level = level;
//
//}
//
//public final boolean covers (ExecutionMode targetMode) {
//return this.level >= targetMode.level;
//}
//}