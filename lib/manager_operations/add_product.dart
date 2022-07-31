import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flux_cart_seller/db/category.dart';
import 'package:flux_cart_seller/db/brand.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String? _currentCategory, currentBrand;

  @override
  void initState() {
    _getCategories();

  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = List<DropdownMenuItem<String>>.empty(growable: true);
    print('Inside getCategoriesDropdown, length of categories is ${categories.length}');
    for (DocumentSnapshot category in categories) {
      print('Inside for loop of getCategoriesDropDown, items,length=${items.length},categories,length=${categories.length}');
      items.add(
        new DropdownMenuItem(
          child: Text(category['category']),
          value: category['category'],
        ),
      );
    }
    print('Inside getCategoriesDropDown, length of itwms is ${items.length}');
    return items;
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
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
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
                )
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
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(categories[index]['category']),
                  );
                },
              ),
            ),
            Center(
              child: DropdownButton(
                value: _currentCategory,
                items: categoriesDropDown,
                onChanged: changeSelectedCategory(_currentCategory),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print('Inside getCategories and length of data is ${data.length}');
    setState(() {

      categories = data;
      print('Length of categories is ${categories.length}');
      categoriesDropDown = getCategoriesDropdown();
      print('Inside initState(), length of getCategoriesDropDown is ${categoriesDropDown.length}');
      _currentCategory = categoriesDropDown[0].value;
      print('Inside setState(), length of categories is ${categories.length}');
    });
    print('Length of categories is ${categories.length}');
  }

  changeSelectedCategory(String? selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory;
    });
  }
}
