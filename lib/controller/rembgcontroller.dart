import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RemoveBgController extends GetxController {
  RxString text = "".obs;
  RxString status = "selectImage".obs;
  RxBool imageisEmpty = false.obs;
  RxBool isDarkThemeEnable = false.obs;
  Rx<Uint8List?> imagePathInBytes = Rx<Uint8List?>(null);
  Rx<File?> selectedimage = Rx<File?>(null);
  String baseUrl = "https://api.remove.bg/v1.0";
  String apiKey = "DyKsbPW2GGMihu4grbhK8md6";
  void checkTheme() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();
    bool themeValue = prefs.getBool('themeValue') ?? false;

    isDarkThemeEnable.value = themeValue;

  }
  Future<void> pickGalleryImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedimage.value = File(pickedImage.path);
      imagePathInBytes.value = await pickedImage!.readAsBytes();
      imageisEmpty.value = false;
    } else {
      text.value = "No image selected";
    }
  }
  void removeBackground() async {
    try {
      var url = Uri.parse('$baseUrl/removebg');
      var req = http.MultipartRequest("POST", url);
      req.headers
          .addAll({"X-API-Key": apiKey, "Content-Type": "multipart/form-data"});
      var file = await http.MultipartFile.fromPath(
        'image_file',
        selectedimage.value!.path,
      );
      req.files.add(file);
      var res = await req.send();
      if (res.statusCode == 200) {
        var responseBytes = await res.stream.toBytes();
        Uint8List imageBytes = Uint8List.fromList(responseBytes);
        File imageFile = File('${selectedimage.value!.parent.path}/output.png');
        await imageFile.writeAsBytes(imageBytes);
        imagePathInBytes.value = imageBytes;
      } else {
        print("Failed: ${res.statusCode} ");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  // Future<void> save() async {
  //   if (imagePathInBytes.value!.isNotEmpty) {
  //     try {
  //       final directory = await getExternalStorageDirectory();
  //       final imagePath = '${directory!.path}/processed_image.png';
  //       final imageFile = File(imagePath);
  //       await imageFile.writeAsBytes(imagePathInBytes.value!);
  //       text.value = "Image saved to $imagePath";
  //       status.value = "save";
  //       imagePathInBytes.value = null;
  //     } catch (e) {
  //       print("The error occured while saving the image is ${e}");
  //     }
  //   } else {
  //     print("No any image to save");
  //   }
  // }
}
