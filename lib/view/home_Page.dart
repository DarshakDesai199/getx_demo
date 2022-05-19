import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/const.dart';
import 'package:getx_demo/controller/counter_controller.dart';
import 'package:getx_demo/view/second_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CounterController counterController = Get.put(CounterController());

  final userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Build Refreshed");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Obx(
              () => Text(
                '${counterController.counter.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                controller: userName,
                decoration: InputDecoration(label: Text("Enter your name ")),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                box.write('username', userName.text);

                /// Navigator push replacement
                Get.off(SecondScreen());

                /// Get.to(page)
                /// for Navigator push
              },
              child: Text("Go to Second Page"),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    "Hii",
                    "Hello",
                    backgroundColor: Colors.blue,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: Text("Get Snackbar")),
            ElevatedButton(
                onPressed: () {
                  Get.dialog(AlertDialog(
                    title: Text("Hii"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("OK"))
                    ],
                  ));
                },
                child: Text("Get Dialog")),
            ElevatedButton(
                onPressed: () {
                  if (Theme.of(context).brightness == Brightness.dark) {
                    Get.changeTheme(ThemeData.light());
                  } else {
                    Get.changeTheme(ThemeData.dark());
                  }
                },
                child: Text("Change Theme")),
            Container(
              height: Get.height * 0.10,
              width: Get.height * 0.10,
              color: Colors.red,
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterController.incrementCounter();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              counterController.decrementCounter();
            },
            tooltip: 'Increment',
            child: Icon(Icons.remove),
          ),
          Obx(
            () => FloatingActionButton(
              backgroundColor: counterController.counter.value == 0
                  ? Colors.red
                  : Colors.blue,
              onPressed: () {
                counterController.refreshCounter();
              },
              tooltip: 'Increment',
              child: Icon(Icons.refresh),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
