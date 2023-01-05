import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:merchant_watches/appication/bottom_nav_bar_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/presentation/add_product/product_cart_items.dart';
import 'package:merchant_watches/presentation/cart/screen_cart.dart';
import 'package:merchant_watches/presentation/home/dashboard.dart';
import 'package:merchant_watches/presentation/wishlist/screen_wishlist.dart';
import 'package:provider/provider.dart';

class CustomBNavBar extends StatelessWidget {
  CustomBNavBar({super.key});
// List for bottom nav bar items
  final List<BottomNavigationBarItem> iconListForBNavBarList = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(
        Icons.home,
        size: 30,
      ),
    ),
    const BottomNavigationBarItem(
      label: 'Cart',
      icon: Icon(
        Icons.shopping_cart_outlined,
        size: 30,
      ),
    ),
    const BottomNavigationBarItem(
      label: 'Add Product',
      icon: Icon(
        Icons.add,
        size: 30,
      ),
    ),
  ];

// pages for body showing the content of the screen
  final List pages = [
    ScreenDashBoard(),
    const ScreenCart(),
    AddProductCartItems()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (context, value, child) => Scaffold(
        bottomNavigationBar: SnakeNavigationBar.color(
          showSelectedLabels: true,
          items: iconListForBNavBarList,
          unselectedItemColor: Colors.white,
          selectedItemColor: primaryFontColor,
          backgroundColor: primaryBackgroundColor,
          behaviour: SnakeBarBehaviour.pinned,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(10),
          currentIndex: value.selectedCurrentIndex,
          height: 60,
          onTap: (index) => value.bottomNavigationChange(index),
          snakeViewColor: primaryBackgroundColor,
        ),
        body: pages[value.selectedCurrentIndex],
      ),
    );
  }
}
