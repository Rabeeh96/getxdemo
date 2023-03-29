import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:demo_getx/models/gallery.dart';
import 'package:demo_getx/services/gallery_service.dart';
import 'package:demo_getx/services/profile_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GalleryController extends GetxController {
  TextEditingController name = new TextEditingController();
  List<XFile> pickedFile = [];
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  List<Gallery> galleries = List<Gallery>.empty(growable: true).obs;

  void selectImage() async {
    try {
      pickedFile = (await ImagePicker().pickMultiImage());
    } finally {
      if (Get.isBottomSheetOpen ?? true) Get.back();
      update();
    }
  }

  void create() async {
    try {
      isLoading(true);
      if (formKey.currentState!.validate()) {
        var arr = [];
        for (var img in pickedFile) {
          arr.add(await Dio.MultipartFile.fromFile(img.path, filename: img.path.split('/').last));
        }
        Dio.FormData formData =   Dio.FormData.fromMap({
          "name": name.text,
          "asd":[],
          "images": arr
        });

        bool result = await GalleryServices.create(formData);
        if (result) clearController();
      }
    } catch (e) {} finally {
      isLoading(false);
    }
  }
  void creates() async {
    try {
      isLoading(true);
      if (formKey.currentState!.validate()) {
        var arr = [];
        var asd;
        for (var img in pickedFile) {
          asd= img.path.split('/').last;
          arr.add(await Dio.MultipartFile.fromFile(img.path, filename: img.path.split('/').last));
        }


        Dio.FormData formData =   Dio.FormData.fromMap({
          "ProductName": "Bag 10245645",
          "ProductCode": "B10345554",
          "PuchasePrice": "230",
          "OriginalPrice": "200",
          "SellingPrice": "300",
          "ProductGroup": "74643ff4-5bd0-4d4d-a0ec-30f1289b494f",
          "TaxTypes": "b5b73ec4-c68e-4fab-bf3e-fa54d2140e0e",
          "IsInclusive": true,
          "Description": "Decptn",
          "ProductCategoty": "75b10107-ecd7-4134-9dca-959e41febf9b",
          "DemoVideo": "null",
          "ProductSubTags": [
            1
          ],
          "MainVariants": [
            {
              "VariantName": "black",
              "VariantPath": [
                asd
              ]
            }
          ],
          "VariantImage": arr,
          "ProductVariants": [
            {
              "ProductVariantName": "S",
              "stock": "10"
            }
          ]
        });


        bool result = await GalleryServices.creates(formData);
        if (result) clearController();
      }
    } catch (e) {} finally {
      isLoading(false);
    }
  }

  void fetch() async {
    try {
      isLoading(true);
      var _data = await GalleryServices.fetch();
      if (_data != null) {
        galleries.assignAll(galleryFromJson(jsonEncode(_data)));
      }
    } finally {
      isLoading(false);
    }
  }

  void clearController() {
    name.clear();
    pickedFile.clear();
    update();
  }
}
