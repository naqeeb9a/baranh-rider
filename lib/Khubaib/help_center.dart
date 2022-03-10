
import 'package:baranh_rider/Khubaib/rating.dart';
import 'package:flutter/material.dart';

import '../Screens/new_orders.dart';
import '../utils/dynamic_sizes.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "Help Center"),
        
          ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: CustomSizes().dynamicHeight(context, 0),
              // horizontal: CustomSizes().dynamicWidth(context, 0.05),
            ),
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return personCard(context,icon:true,marginline: true);
            },
          ),
        ],
      ),
    );
  }
}
