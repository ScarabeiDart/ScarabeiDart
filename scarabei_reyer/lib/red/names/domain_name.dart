import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/path/relative_path.dart';
import 'package:scarabei/api/utils/utils.dart';

class DomainName implements ID {
  RelativePath _steps;

  DomainName({List<String> steps, String raw_id_string}) {
    if (steps == null) {
      Debug.checkTrue(Names.isValidString(raw_id_string), "String <$raw_id_string> validity");
      steps = raw_id_string.split(ID.SEPARATOR);
    }
    this._steps = Utils.newRelativePath(path_steps: steps);
  }

  @override
  ID child(String string) => new DomainName(steps: this._steps.child(string).steps());

  @override
  String getLastStep() => this._steps.getLastStep();

  @override
  bool includes(ID other) => this._steps.beginsWith(Utils.newRelativePath(path_steps: other.steps()));

  @override
  ID parent() => new DomainName(steps: this._steps.parent().steps());

  @override
  ID proceed(ID subpackage) =>
      new DomainName(steps: this._steps.proceed(Utils.newRelativePath(path_steps: subpackage.steps())).steps());

  @override
  List<String> steps() {
    return this._steps.steps();
  }
}
