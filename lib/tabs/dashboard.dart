import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:flux_cart_seller/db/category.dart';
import 'package:flux_cart_seller/db/brand.dart';
import 'package:flux_cart_seller/constants.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          subtitle: OutlinedButton.icon(
            onPressed: null,
            icon: Icon(
              Icons.attach_money,
              size: 30.0,
              color: Colors.green,
            ),
            label: Text('12,000',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, color: Colors.green)),
          ),
          title: Text(
            'Revenue',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.grey),
          ),
        ),
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.all(Constants.default_grid_padding),
                child: Card(
                  child: ListTile(
                      title: ElevatedButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.people_outline),
                          label: Text("Users")),
                      subtitle: Text(
                        '7',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: active, fontSize: 60.0),
                      )),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(Constants.default_grid_padding),
                child: Card(
                  child: ListTile(
                      title: ElevatedButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.category),
                          label: Text("Categories")),
                      subtitle: Text(
                        '23',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: active, fontSize: 60.0),
                      )),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(Constants.default_grid_padding),
                child: Card(
                  child: ListTile(
                      title: ElevatedButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.track_changes),
                          label: Text("Products")),
                      subtitle: Text(
                        '120',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: active, fontSize: 60.0),
                      )),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(Constants.default_grid_padding),
                child: Card(
                  child: ListTile(
                      title: ElevatedButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.tag_faces),
                          label: Text("Sold")),
                      subtitle: Text(
                        '13',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: active, fontSize: 60.0),
                      )),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(Constants.default_grid_padding),
                child: Card(
                  child: ListTile(
                      title: ElevatedButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.shopping_cart),
                          label: Text("Orders")),
                      subtitle: Text(
                        '5',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: active, fontSize: 60.0),
                      )),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(Constants.default_grid_padding),
                child: Card(
                  child: ListTile(
                      title: ElevatedButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.close),
                          label: Text("Return")),
                      subtitle: Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: active, fontSize: 60.0),
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


