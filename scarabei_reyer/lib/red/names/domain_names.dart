import 'package:scarabei/api/names/names.dart';
import 'package:scarabei_reyer/red/names/domain_name.dart';

class DomainNames implements NamesComponent {
  ID newID({List<String> steps, String raw_id_string}) {
    return new DomainName(steps: steps, raw_id_string: raw_id_string);
  }

  String SEPARATOR() {
    return ".";
  }

  ID ROOT() {
    return new DomainName(raw_id_string: "");
  }

  bool isValidString(final String value) {
    return value != null;
  }
}
