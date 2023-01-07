import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:merchant_watches/appication/add_product_provider.dart';
import 'package:merchant_watches/infrastructure/add_products/add_products.dart';
import 'package:provider/provider.dart';

class ScreenDashBoard extends StatelessWidget {
  const ScreenDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
              onPressed: () async {
                // Provider.of<AddProductProvider>(context,listen: false).getData();
              },
              icon: Icon(Icons.access_alarm))),
    );
  }
}
