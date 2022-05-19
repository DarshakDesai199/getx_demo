import 'package:get/get.dart';
import 'package:getx_demo/api_services/api_service.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  RxBool isLoading = true.obs;

  var productList = <Poduct>[].obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    isLoading(true);

    try {
      final products = await ApiServices.fetchProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}
