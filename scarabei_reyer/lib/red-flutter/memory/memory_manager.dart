import 'package:scarabei/api/memory/memory_manager.dart';
import 'package:scarabei/api-flutter/mobile_device.dart';

//import com.jfixby.scarabei.android.api.Android;
//import com.jfixby.scarabei.api.memory.MemoryManagerComponent;

class FlutterMemoryManager implements MemoryManagerComponent {


  int getMaxHeapSize() {
    return MobileDevice.getMaxHeapSize();
  }


  int getRecommendedHeapSize() {
    return MobileDevice.getRecommendedHeapSize();
  }

}
