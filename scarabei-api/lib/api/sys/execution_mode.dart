class ExecutionMode {
  static const EARLY_DEVELOPMENT = const ExecutionMode._(3000, "EARLY_DEVELOPMENT");
  static const TESTING = const ExecutionMode._(2000, "TESTING");
  static const RELEASE_CANDIDATE = const ExecutionMode._(1000, "RELEASE_CANDIDATE");
  static const DEMO = const ExecutionMode._(500, "DEMO");
  static const PUBLIC_RELEASE = const ExecutionMode._(0, "PUBLIC_RELEASE");


  @override
  String toString() {
    return name;
  }

  static get values => [EARLY_DEVELOPMENT, TESTING, RELEASE_CANDIDATE, DEMO, PUBLIC_RELEASE];

  final int value;
  final String name;

  const ExecutionMode._(this.value, this.name);

  bool isAtLeast(ExecutionMode targetMode) => this.value >= targetMode.value;

  bool isBelow(ExecutionMode targetMode) => this.value < targetMode.value;



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