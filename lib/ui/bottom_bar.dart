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

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      final bool isBuyer =
          Provider.of<UserProvider>(context, listen: false).getRole() ==
              "Acheteur";
      final List<String> routes = isBuyer
          ? <String>["/", "/cart", "/orders", "/profil"]
          : <String>["/", "/cart", "/orders", "/profil"];
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
                  destinations: const <NavigationRailDestination>[
                    // navigation destinations
                    NavigationRailDestination(
                      icon: Icon(Icons.search, size: 30),
                      label: Text(''),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.shopping_cart_outlined, size: 30),
                      label: Text(''),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.format_list_bulleted, size: 30),
                      label: Text(''),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person, size: 30),
                      label: Text(''),
                    ),
                  ],
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
              backgroundColor: backgroundColor,
              buttonBackgroundColor: primaryColor,
              items: const <Widget>[
                Icon(Icons.search, size: 30),
                Icon(Icons.shopping_cart_outlined, size: 30),
                Icon(Icons.format_list_bulleted, size: 30),
                Icon(Icons.person, size: 30),
              ],
              onTap: _onItemTapped,
            )
          : null,
    );
  }
}
