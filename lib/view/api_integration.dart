import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/controller/internet_controller.dart';
import 'package:getx_demo/controller/product_controller.dart';

class apisIntegration extends StatefulWidget {
  @override
  State<apisIntegration> createState() => _apisIntegrationState();
}

class _apisIntegrationState extends State<apisIntegration> {
  ProductController productController = Get.put(ProductController());

  ConnectivityProvider connectivityProvider = Get.put(ConnectivityProvider());
  @override
  void initState() {
    connectivityProvider.startMonitoring();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
      body: GetBuilder<ConnectivityProvider>(
        builder: (controller) {
          return controller.isOnline
              ? Obx(() {
                  if (productController.isLoading.value) {
                    return Center(child: CupertinoActivityIndicator());
                  } else {
                    return GridView.builder(
                      itemCount: productController.productList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
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
                })
              : Text("No Internet");
        },
      ),
    );
  }
}
