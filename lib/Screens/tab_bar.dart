
import 'package:baranh_rider/Screens/person.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Khubaib/order_screen.dart';
import '../utils/config.dart';
import '../utils/dynamic_sizes.dart';
import 'login.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  double iconSize = 0.05;
  bool _loading = true;

  @override
  void initState() {
    checkLoginStatus(
      context,
    );
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading == true
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()))
        : Scaffold(
            body: DefaultTabController(
              length: 2,
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  OrderScreen(),
                  Profile(),
                ],
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: CustomSizes().dynamicHeight(context, 0.07),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: const TextStyle(color: CustomColors.customGrey),
                unselectedLabelColor: CustomColors.customBlack,
                unselectedLabelStyle:
                    const TextStyle(color: CustomColors.customGrey),
                controller: _tabController,
                labelColor: Colors.amber,
                indicatorColor: Colors.amber,
                tabs: const [
                  Tab(
                      text: "Order",
                      icon: Icon(
                        Icons.list,
                        color: CustomColors.customYellow,
                      )),
                  Tab(
                      text: "Profile",
                      icon: Icon(
                        Icons.person,
                        color: CustomColors.customYellow,
                      )),
                ],
              ),
            ),
          );
  }

  checkLoginStatus(
    BuildContext context,
  ) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    if (userData.getString("user") == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      setState(() {
        _loading = false;
      });
    }
  }
}
