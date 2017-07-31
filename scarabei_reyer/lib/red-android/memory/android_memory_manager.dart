import 'package:scarabei/api-android/android.dart';
import 'package:scarabei/api/memory/memory_manager.dart';

//import com.jfixby.scarabei.android.api.Android;
//import com.jfixby.scarabei.api.memory.MemoryManagerComponent;

class AndroidMemoryManager implements MemoryManagerComponent {


  int getMaxHeapSize() {
    return Android.getMaxHeapSize();
  }


  int getRecommendedHeapSize() {
    return Android.getRecommendedHeapSize();
  }

}