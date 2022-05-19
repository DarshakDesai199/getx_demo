import 'package:get/get.dart';

class CounterController extends GetxController {
  RxInt counter = 0.obs;

  incrementCounter() {
    counter++;
    update();
  }

  decrementCounter() {
    if (counter > 0) {
      counter--;
    }
    update();
  }

  refreshCounter() {
    counter.value = 0;
    update();
  }
}
