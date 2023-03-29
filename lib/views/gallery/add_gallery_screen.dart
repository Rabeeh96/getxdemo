import 'dart:io';

import 'package:flutter/material.dart';
import 'package:demo_getx/controllers/galleryController.dart';
import 'package:demo_getx/widgets/loading_button.dart';
import 'package:get/get.dart';

class AddGalleryScreen extends StatefulWidget {
  @override
  _AddGalleryScreenState createState() => _AddGalleryScreenState();
}

class _AddGalleryScreenState extends State<AddGalleryScreen> {
  final ScrollController _scrollController =   ScrollController();
  final galleryController = Get.put(GalleryController());

  @override
  void initState() {
    // TODO: implement initState
    galleryController.clearController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Gallery'),
      ),
      body: Container(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: galleryController.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: galleryController.name,
                  onEditingComplete: () => node.nextFocus(),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter your last name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    galleryController.selectImage();
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 40,
                    width: 125,
                    child: const Center(
                      child: Text(
                        'Add Image',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GetBuilder<GalleryController>(
                  builder: (_c) => GridView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: galleryController.pickedFile.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Image(
                            image: FileImage(
                          File(galleryController.pickedFile[index].path),
                        ),
                          fit: BoxFit.cover,
                        );
                      }),
                ),
                const SizedBox(height: 40),
                Obx(() {
                  if (galleryController.isLoading.value) {
                    return LoadingButton(
                      onClick: () async {},
                      color: Colors.blue,
                      childWidget: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return LoadingButton(
                      onClick: () async {
                        // galleryController.create();
                         galleryController.creates();
                      },
                      color: Colors.blue,
                      childWidget: const Center(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                      ),
                    );
                  }
                }),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
