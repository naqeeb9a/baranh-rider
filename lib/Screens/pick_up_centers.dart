
import 'package:baranh_rider/Screens/login.dart';
import 'package:baranh_rider/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

import '../Widgets/buttons.dart';
import '../Widgets/loader.dart';
import '../Widgets/text_widget.dart';
import '../backend/orders.dart';
import '../utils/config.dart';
import 'map.dart';

class PickUpCenters extends StatelessWidget {
  const PickUpCenters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context,
          text1: "Pick-up Centers",
          automaticallyImplyLeading: true,
          backgroundColor: CustomColors.customYellow),
      body: FutureBuilder(
          future: RiderFunctionality().getRiderPickUpCenters("pick-up-centres"),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == false) {
                return retry(context);
              } else if (snapshot.data.length == 0) {
                return text(context, "No Pick-up Centers", 0.04,
                    CustomColors.customBlack);
              } else {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: CustomSizes().dynamicHeight(context, 0.01),
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return pickUpCentersCard(context, snapshot, index);
                  },
                );
              }
            } else {
              return const Loader();
            }
          }),
    );
  }

  pickUpCentersCard(context, AsyncSnapshot snapshot, index) {
    return Container(
      margin: EdgeInsets.all(CustomSizes().dynamicWidth(context, 0.02)),
      padding: EdgeInsets.symmetric(
          horizontal: CustomSizes().dynamicWidth(context, 0.04)),
      decoration: BoxDecoration(
          color: CustomColors.customGrey.withOpacity(0.3),
          borderRadius:
              BorderRadius.circular(CustomSizes().dynamicWidth(context, 0.04))),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          CircleAvatar(
            radius: CustomSizes().dynamicWidth(context, 0.3),
            backgroundImage: NetworkImage(snapshot.data[index]
                    ["pick_up_image"] ??
                "https://cdn-media-2.freecodecamp.org/w1280/5f9c9e5e740569d1a4ca3cbb.jpg"),
          ),
          ListTile(
            leading: text(context, snapshot.data[index]["pick_up_location"],
                0.04, CustomColors.customBlack),
            trailing: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DisplayMap(
                                latitude: snapshot.data[index]["lat"],
                                longitude: snapshot.data[index]["lng"],
                              )));
                },
                child: const Icon(Icons.location_pin)),
          ),
        ],
      ),
    );
  }
}
