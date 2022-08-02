import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flux_cart_seller/db/category.dart';
import 'package:flux_cart_seller/db/brand.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flux_cart_seller/db/product.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService productService = ProductService();

  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController productNameController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<DocumentSnapshot<Map<String, dynamic>>> brands =
      <DocumentSnapshot<Map<String, dynamic>>>[];
  List<DocumentSnapshot<Map<String, dynamic>>> categories =
      <DocumentSnapshot<Map<String, dynamic>>>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  String? _currentCategory, _currentBrand;
  ImagePicker imagePicker = ImagePicker();
  bool isLoading = false;

  List<String> selectedSizes = <String>[];
  XFile? _image1;
  XFile? _image2;
  XFile? _image3;

  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.close,
          color: black,
        ),
        backgroundColor: white,
        title: Text(
          "Add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        _selectImage(ImagePicker)
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                  */

                        /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  )*/
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                                onPressed: () {
                                  _selectImage(
                                      imagePicker.pickImage(
                                          source: ImageSource.gallery),
                                      1);
                                },
                                child: _displayChild1()),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                                onPressed: () {
                                  _selectImage(
                                      imagePicker.pickImage(
                                          source: ImageSource.gallery),
                                      2);
                                },
                                child: _displayChild2()),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                _selectImage(
                                    imagePicker.pickImage(
                                        source: ImageSource.gallery),
                                    3);
                              },
                              child: _displayChild3(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enter product name:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(hintText: 'Product Name'),
                        validator: (value) {
                          if (value?.isEmpty ?? false)
                            return 'You must enter the product name';
                          else if (value!.length > 20) {
                            return 'Product name can\'t have more than 10 characters';
                          }
                        },
                      ),
                    ),
                    /*    Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(categories[index]['category']),
                    );
                  },
                ),
              ),*/
                    Row(
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: _currentCategory,
                            items: categoriesDropDown,
                            onChanged: (String? newValue) {
                              setState(() {
                                _currentCategory = newValue;
                              });
                            },
                          ),
                        ),
                        Text(
                          'Brand',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: _currentBrand,
                            items: brandsDropDown,
                            onChanged: (String? newValue) {
                              setState(() {
                                _currentBrand = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: productQuantityController,
                        //initialValue: '1',
                        decoration: InputDecoration(
                            hintText: 'Quantity', labelText: 'Quantity'),
                        validator: (value) {
                          if (value?.isEmpty ?? false)
                            return 'You must enter the available quantity';
                          /* else if (value!.length > 20) {
                      return 'Product name can\'t have more than 10 characters';*/
                          //}
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        //initialValue: '1.00',
                        keyboardType: TextInputType.number,
                        controller: priceController,
                        decoration: InputDecoration(
                            hintText: 'Price', labelText: 'Price'),
                        validator: (value) {
                          if (value?.isEmpty ?? false)
                            return 'You must enter the correct prices';
                          /* else if (value!.length > 20) {
                      return 'Product name can\'t have more than 10 characters';*/
                          //}
                        },
                      ),
                    ),
                    Text('Available Sizes'),
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: selectedSizes.contains('XS'),
                            onChanged: (value) {
                              changeSelectedSize('XS');
                            }),
                        Text('XS'),
                        Checkbox(
                            value: selectedSizes.contains('S'),
                            onChanged: (value) => changeSelectedSize('S')),
                        Text('S'),
                        Checkbox(
                            value: selectedSizes.contains('M'),
                            onChanged: (value) => changeSelectedSize('M')),
                        Text('M'),
                        Checkbox(
                            value: selectedSizes.contains('L'),
                            onChanged: (value) => changeSelectedSize('L')),
                        Text('L'),
                        Checkbox(
                            value: selectedSizes.contains('XL'),
                            onChanged: (value) => changeSelectedSize('XL')),
                        Text('XL'),
                        Checkbox(
                            value: selectedSizes.contains('XXL'),
                            onChanged: (value) => changeSelectedSize('XXL')),
                        Text('XXL'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: selectedSizes.contains('28'),
                            onChanged: (value) => changeSelectedSize('28')),
                        Text('28'),
                        Checkbox(
                            value: selectedSizes.contains('30'),
                            onChanged: (value) => changeSelectedSize('30')),
                        Text('30'),
                        Checkbox(
                            value: selectedSizes.contains('32'),
                            onChanged: (value) => changeSelectedSize('32')),
                        Text('32'),
                        Checkbox(
                            value: selectedSizes.contains('34'),
                            onChanged: (value) => changeSelectedSize('34')),
                        Text('34'),
                        Checkbox(
                            value: selectedSizes.contains('36'),
                            onChanged: (value) => changeSelectedSize('36')),
                        Text('36'),
                        Checkbox(
                            value: selectedSizes.contains('38'),
                            onChanged: (value) => changeSelectedSize('38')),
                        Text('38'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: selectedSizes.contains('40'),
                            onChanged: (value) => changeSelectedSize('40')),
                        Text('40'),
                        Checkbox(
                            value: selectedSizes.contains('42'),
                            onChanged: (value) => changeSelectedSize('42')),
                        Text('42'),
                        Checkbox(
                            value: selectedSizes.contains('44'),
                            onChanged: (value) => changeSelectedSize('44')),
                        Text('44'),
                        Checkbox(
                            value: selectedSizes.contains('46'),
                            onChanged: (value) => changeSelectedSize('46')),
                        Text('46'),
                        Checkbox(
                            value: selectedSizes.contains('48'),
                            onChanged: (value) => changeSelectedSize('48')),
                        Text('48'),
                        Checkbox(
                            value: selectedSizes.contains('50'),
                            onChanged: (value) => changeSelectedSize('50')),
                        Text('50'),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          validateAndUpload();
                        },
                        child: Text('Add Item ')),
                  ],
                ),
        ),
      ),
    );
  }

  void _getCategories() async {
    List<DocumentSnapshot<Map<String, dynamic>>> data =
        await _categoryService.getCategories();
    print('Inside getCategories and length of data is ${data.length}');
    setState(() {
      categories = data;
      print('Length of categories is ${categories.length}');
      categoriesDropDown = getCategoriesDropdown();
      print('Length of categoriesDropDown=${categoriesDropDown.length}');
      //_currentCategory = categoriesDropDown[0].value;
      Map<String, dynamic>? map = categories[0].data();
      _currentCategory = map!['category'];
      print('Inside setState(), length of categories is ${categories.length}');
    });
    print('Length of categories is ${categories.length}');
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items =
        List<DropdownMenuItem<String>>.empty(growable: true);
    print(
        'Inside getCategoriesDropdown, length of categories is ${categories.length}');
    for (DocumentSnapshot<Map<String, dynamic>> category in categories) {
      /* print('Inside for loop of getCategoriesDropDown, items,length=${items.length},categories,length=${categories.length}');*/
      setState(() {
        Map<String, dynamic>? map = category.data();
        items.add(
          DropdownMenuItem(
            value: category['category'],
            child: Text(map!['category']),
          ),
        );
      });
    }
    print('Inside getCategoriesDropDown, length of itwms is ${items.length}');
    return items;
  }

  void _getBrands() async {
    List<DocumentSnapshot<Map<String, dynamic>>> data =
        await _brandService.getBrands();

    setState(() {
      brands = data;

      brandsDropDown = getBrandsDropdown();

      //_currentCategory = categoriesDropDown[0].value;
      Map<String, dynamic>? map = brands[0].data();
      _currentBrand = map!['brand'];
    });
  }

  List<DropdownMenuItem<String>> getBrandsDropdown() {
    List<DropdownMenuItem<String>> items =
        List<DropdownMenuItem<String>>.empty(growable: true);

    for (DocumentSnapshot<Map<String, dynamic>> brand in brands) {
      /* print('Inside for loop of getCategoriesDropDown, items,length=${items.length},categories,length=${categories.length}');*/
      setState(() {
        Map<String, dynamic>? map = brand.data();
        items.add(
          DropdownMenuItem(
            value: brand['brand'],
            child: Text(map!['brand']),
          ),
        );
      });
    }

    return items;
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  void _selectImage(Future<XFile?> pickImage, int imageNumber) async {
    XFile? tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = tempImg);
        break;
      case 2:
        setState(() => _image2 = tempImg);
        break;
      case 3:
        setState(() => _image3 = tempImg);
        break;
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        File(_image1!.path),
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        File(_image2!.path),
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        File(_image3!.path),
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      if (_image1 != null && _image2 != null && _image3 != null) {
        if (selectedSizes.isEmpty) {
          Fluttertoast.showToast(msg: 'Select at least one size');
        } else {
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;
          try {
            Reference storageRef = FirebaseStorage.instance.ref();
            final String picture1 =
                "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg"; //Provide different name to each image
            final ref1 = storageRef.child(picture1);
            String path = _image1!.path;
            final metadata = SettableMetadata(
                contentType: "image/jpeg"); //Create the file meta data
            UploadTask uploadTask1 = ref1.putFile(File(path), metadata);

            final String picture2 =
                "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg"; //Provide different name to each image
            final ref2 = storageRef.child(picture2);
            String path2 = _image1!.path;
            // final metadata = SettableMetadata(contentType: "image/jpeg");//Create the file meta data
            UploadTask uploadTask2 = ref2.putFile(File(path2), metadata);

            final String picture3 =
                "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg"; //Provide different name to each image
            final ref3 = storageRef.child(picture3);
            String path3 = _image1!.path;
            //final metadata = SettableMetadata(contentType: "image/jpeg");//Create the file meta data
            UploadTask uploadTask3 = ref3.putFile(File(path3), metadata);

            TaskSnapshot snapshot1 = await uploadTask1;
            TaskSnapshot snapshot2 = await uploadTask2;
            TaskSnapshot snapshot3 = await uploadTask3;
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            imageUrl2 = await snapshot2.ref.getDownloadURL();
            imageUrl3 = await snapshot3.ref.getDownloadURL();
            print('Image urls are $imageUrl1  $imageUrl2  $imageUrl3');
            List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];
            productService.uploadProduct(
                productName: productNameController.text,
                price: double.parse(priceController.text),
                quantity: int.parse(productQuantityController.text),
                images: imageList,
                brand: _currentBrand ?? 'Not Available',
                category: _currentCategory ?? 'Not Available',
                sizes: selectedSizes);
          } catch (e) {
            print('Error is $e');
          }
          Fluttertoast.showToast(msg: 'Product Added');
          _formKey.currentState?.reset();
          setState(() => isLoading = false);
          Navigator.pop(context);

          /*  // Listen for state changes, errors, and completion of the upload.
                uploadTask3.snapshotEvents.listen((TaskSnapshot taskSnapshot) async{
                  switch (taskSnapshot.state) {
                    case TaskState.running:
                      final progress =
                          100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
                      print("Upload is $progress% complete.");
                      break;
                    case TaskState.paused:
                      print("Upload is paused.");
                      break;
                    case TaskState.canceled:
                      print("Upload was canceled");
                      break;
                    case TaskState.error:
                    // Handle unsuccessful uploads
                      break;
                    case TaskState.success:
                    // Handle successful uploads on complete
                    // ...

                      break;
                  }
              });*/
        }
      } else {
        Fluttertoast.showToast(msg: 'All images must be provided');
        setState(()
            {
              isLoading=false;
            });
      }
    }
  }
}
