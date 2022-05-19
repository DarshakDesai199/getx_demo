import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/controller/product_controller.dart';

class apisIntegration extends StatelessWidget {
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CupertinoActivityIndicator());
        } else {
          return GridView.builder(
            itemCount: productController.productList.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    Text(productController.productList[index].name!),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
