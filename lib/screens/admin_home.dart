import 'package:flutter/material.dart';
import 'package:flux_cart_seller/tabs/manager.dart';
import 'package:flux_cart_seller/tabs/dashboard.dart';
class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        title: Text('Welcome Seller'),
        bottom: TabBar(

          onTap: (index)
          {
            
          },
          tabs: [Tab(
            icon: Icon(Icons.dashboard_rounded),
            text: 'Dashboard',
          ),Tab(
            icon: Icon(Icons.manage_accounts),
            text: 'Manage Profile',
          )],
        ),
      ),
      body: TabBarView(
        children: [
         Dashboard(),
          Manager()
        ],
      ),
    ),
    );
  }
}
