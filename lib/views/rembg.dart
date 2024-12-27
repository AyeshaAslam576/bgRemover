import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:removebg/controller/rembgcontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Rembg extends StatelessWidget {
  const Rembg({super.key});
  @override
  Widget build(BuildContext context) {
    final RemoveBgController removeBgController = Get.put(RemoveBgController());
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .focusColor,
        title: Text(
          "Remove Background",
          style: GoogleFonts.sen(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          Text("Theme"),
          Obx(() {
            return Switch(
                value: removeBgController.isDarkThemeEnable.value,
                onChanged: (value) async {
                  final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  await prefs.setBool('themeValue', value);
                  removeBgController.checkTheme();
                });
          })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Obx(() {
              return removeBgController.imagePathInBytes.value != null
                  ? DottedBorder(
                color:  Theme.of(context).focusColor,
                strokeWidth: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(
                            removeBgController.imagePathInBytes.value!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
                  : DottedBorder(
                color: Theme.of(context).focusColor,
                strokeWidth: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Image is not selected",
                        style: GoogleFonts.sen(
                            textStyle: TextStyle(
                                color:  Theme.of(context).focusColor, fontSize: 18)),
                      ),
                    ),
                  ),
                ),
              );
            }),
            Spacer(),
            Obx(() {
              if (removeBgController.status.value == "selectImage") {
                return Visibility(
                  visible: true,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:  Theme.of(context).focusColor,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        removeBgController.pickGalleryImage();
                        removeBgController.status.value = "removebg";
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        side: BorderSide.none,
                        backgroundColor: Theme.of(context).focusColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Select Image from gallery",
                        style: GoogleFonts.sen(
                          textStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (removeBgController.status.value == "removebg") {
                return Visibility(
                  visible: true,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:  Theme.of(context).focusColor,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        removeBgController.removeBackground();
                        removeBgController.status.value = "selectImage";
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).focusColor,
                        side: BorderSide.none,
                        elevation: 0,
                      ),
                      child: Text(
                        "Remove Background",
                        style: GoogleFonts.sen(
                          textStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }
              // else if (removeBgController.status.value == "save") {
              //   return Visibility(
              //     visible: true,
              //     child: Container(
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         color:  Theme.of(context).focusColor,
              //       ),
              //       child: ElevatedButton(
              //         onPressed: () {
              //           removeBgController.save();
              //         },
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor:  Theme.of(context).focusColor,
              //           side: BorderSide.none,
              //           elevation: 0,
              //         ),
              //         child: Text(
              //           "Save Changes",
              //           style: GoogleFonts.sen(
              //             textStyle: TextStyle(color: Colors.white),
              //           ),
              //         ),
              //       ),
              //     ),
              //   );
              // }
              else{
                return SizedBox(
                  height: 10,
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
