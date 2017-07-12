import 'package:scarabei_api/names/id.dart';


abstract class NamesComponent {

  ID newID({List<String> steps, String raw_id_string});

  String SEPARATOR();

  ID ROOT();

}
