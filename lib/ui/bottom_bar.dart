import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';
import 'package:flutter_du_13/providers/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  State<BottomBar> createState() => _BottomBarState();
}

List<NavigationRailDestination> getWebBuyerBottomBar() {
  return <NavigationRailDestination>[
    // navigation destinations
    const NavigationRailDestination(
      icon: Icon(Icons.search, size: 30),
      label: Text(''),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.shopping_cart_outlined, size: 30),
      label: Text(''),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.format_list_bulleted, size: 30),
      label: Text(''),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.person, size: 30),
      label: Text(''),
    ),
  ];
}

List<NavigationRailDestination> getWebSellerBottomBar() {
  return <NavigationRailDestination>[
    // navigation destinations
    const NavigationRailDestination(
      icon: Icon(Icons.search, size: 30),
      label: Text(''),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.add_circle_outlined, size: 30),
      label: Text(''),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.format_list_bulleted, size: 30),
      label: Text(''),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.person, size: 30),
      label: Text(''),
    ),
  ];
}

List<Widget> getMobileBuyerBottomBar() {
  return <Widget>[
    const Icon(Icons.search, size: 30),
    const Icon(Icons.shopping_cart_outlined, size: 30),
    const Icon(Icons.format_list_bulleted, size: 30),
    const Icon(Icons.person, size: 30)
  ];
}

List<Widget> getMobileSellerBottomBar() {
  return <Widget>[
    const Icon(Icons.search, size: 30),
    const Icon(Icons.add_circle_outlined, size: 30),
    const Icon(Icons.format_list_bulleted, size: 30),
    const Icon(Icons.person, size: 30)
  ];
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  bool isBuyer = true;

  @override
  void initState() {
    super.initState();
    isBuyer = Provider.of<UserProvider>(context, listen: false).getRole() ==
        "Acheteur";
  }

  void _onItemTapped(int index) {
    setState(() {
      // isBuyer =
      //     Provider.of<UserProvider>(context, listen: false).getRole() ==
      //         "Acheteur";
      final List<String> routes = isBuyer
          ? <String>["/", "/cart", "/orders", "/profil"]
          : <String>["/", "/addProduct", "/sellOrders", "/profil"];
      context.go(routes[index]);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !kIsWeb
          ? widget.child
          : Row(
              children: <Widget>[
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onItemTapped,
                  labelType: NavigationRailLabelType.selected,
                  backgroundColor: backgroundLighterColor,
                  destinations: isBuyer
                      ? getWebBuyerBottomBar()
                      : getWebSellerBottomBar(),
                  selectedIconTheme: const IconThemeData(color: primaryColor),
                  unselectedIconTheme: const IconThemeData(color: textColor),
                  unselectedLabelTextStyle: const TextStyle(color: textColor),
                  selectedLabelTextStyle: const TextStyle(color: primaryColor),
                ),
                Expanded(child: widget.child)
              ],
            ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: !kIsWeb
          ? CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: primaryColor,
              items: isBuyer
                  ? getMobileBuyerBottomBar()
                  : getMobileSellerBottomBar(),
              onTap: _onItemTapped,
            )
          : null,
    );
  }
}
