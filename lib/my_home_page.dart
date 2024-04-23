import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_3d_model/inverted_circle_clipper.dart';
import 'package:o3d/o3d.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  O3DController o3dController = O3DController();
  PageController mainPageController = PageController();
  PageController textsPageController = PageController();
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Stack(
        children: [
          O3D(
            src: 'assets/disney_style_character.glb',
            controller: o3dController,
            ar: false,
            autoPlay: true,
            // autoRotate: false,
            // cameraControls: false,
            // cameraTarget: CameraTarget(-.25, 1.5, 1.5),
            // cameraOrbit: CameraOrbit(0, 90, 1),
          ),
          PageView(
            controller: mainPageController,
            children: [
              const Center(),
              const Center(),
              ClipPath(
                clipper: InvertedCircleClipper(),
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          ),
          Container(
            width: 100,
            height: double.infinity,
            margin: const EdgeInsets.all(12),
            child: PageView(
              controller: textsPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text('Daily Goals'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Expanded(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("87"),
                            ),
                          ),
                          Transform.translate(
                              offset: Offset(0, 20), child: Text("%")),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.local_fire_department_outlined,
                            color: Colors.red,
                          ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("1,840"),
                            Text(
                              "Calories",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.do_not_step,
                            color: Colors.purple,
                          ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("3,480"),
                            Text(
                              "Steps",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.hourglass_bottom,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("6.5"),
                            Text(
                              "Hours",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text('Journal'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("12"),
                            ),
                          ),
                          Transform.translate(
                              offset: Offset(0, 20), child: Text("<")),
                        ],
                      ),
                    ),
                    const Text(
                      "April 2024",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text('Profile'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text("Dis"),
                      ),
                    ),
                    Text(
                      "23 years old",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (page) {
          mainPageController.animateToPage(page,
              duration: const Duration(microseconds: 500), curve: Curves.ease);
          textsPageController.animateToPage(page,
              duration: const Duration(microseconds: 500), curve: Curves.ease);

          if (page == 0) {
            o3dController.cameraTarget(-.25, 1.5, 1.5);
            o3dController.cameraOrbit(0, 90, 1);
          } else if (page == 1) {
            o3dController.cameraTarget(0, 1.8, 0);
            o3dController.cameraOrbit(-90, 90, 1.5);
          } else if (page == 2) {
            o3dController.cameraTarget(0, 3, 0);
            o3dController.cameraOrbit(0, 90, -3);
          }

          setState(() {
            this.page = page;
          });
        },
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.timer_outlined), label: 'Timer'),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined), label: 'Home'),
        ],
      ),
    );
  }
}
