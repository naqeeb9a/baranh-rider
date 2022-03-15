import 'package:baranh_rider/utils/config.dart';
import 'package:baranh_rider/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/login.dart';
import '../Screens/order_summary_page.dart';
import '../Widgets/buttons.dart';
import '../Widgets/loader.dart';
import '../Widgets/text_widget.dart';
import '../backend/orders.dart';
import '../utils/app_routes.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: CustomColors.customBlack,
        appBar: customAppbar(
          context: context,
          text1: "Orders",
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.customOrange,
        ),
        body: Column(
          children: [
            CustomSizes().heightBox(context, .02),
            SizedBox(
              height: CustomSizes().dynamicHeight(context, .04),
              child: TabBar(
                physics: const NeverScrollableScrollPhysics(),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    100.0,
                  ),
                  color: CustomColors.customOrange,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: CustomColors.customWhite,
                unselectedLabelColor: CustomColors.customOrange,
                labelStyle: TextStyle(
                  fontSize: CustomSizes().dynamicWidth(context, .034),
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: CustomSizes().dynamicWidth(context, .032),
                  fontWeight: FontWeight.normal,
                ),
                tabs: const [
                  Tab(
                    text: "New Orders",
                  ),
                  Tab(
                    text: "Picked Orders",
                  ),
                  Tab(
                    text: "Delivered Orders",
                  ),
                ],
              ),
            ),
            CustomSizes().heightBox(context, .02),
            Expanded(
              child: StreamBuilder(
                  stream: Stream.periodic(const Duration(minutes: 10)),
                  builder: (context, snapshot) {
                    return TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        FutureBuilder(
                          future: RiderFunctionality().getRiderInfo(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data == false) {
                                return retry(context);
                              } else if (snapshot.data.length == 0) {
                                return Center(
                                  child: text(context, "No Active Orders", 0.04,
                                      CustomColors.customWhite),
                                );
                              } else {
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    setState(() {});
                                  },
                                  child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (snapshot.data[index]["delorderstatus"]
                                                  .toString() ==
                                              "pending" ||
                                          snapshot.data[index]["delorderstatus"]
                                                  .toString() ==
                                              "null" ||
                                          snapshot.data[index]["delorderstatus"]
                                              .toString()
                                              .isEmpty) {
                                        return activeOrderCard(
                                          context,
                                          snapshot.data,
                                          index,
                                          setState,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                );
                              }
                            } else {
                              return const Loader();
                            }
                          },
                        ),
                        FutureBuilder(
                          future: RiderFunctionality().getRiderInfo(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data == false) {
                                return retry(context);
                              } else if (snapshot.data.length == 0) {
                                return Center(
                                  child: text(context, "No Active Orders", 0.04,
                                      CustomColors.customWhite),
                                );
                              } else {
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    setState(() {});
                                  },
                                  child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (snapshot.data[index]["delorderstatus"]
                                              .toString() ==
                                          "On the way") {
                                        return activeOrderCard(
                                          context,
                                          snapshot.data,
                                          index,
                                          setState,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                );
                              }
                            } else {
                              return const Loader();
                            }
                          },
                        ),
                        FutureBuilder(
                          future: RiderFunctionality().getRiderInfo(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data == false) {
                                return retry(context);
                              } else if (snapshot.data.length == 0) {
                                return Center(
                                  child: text(context, "No Active Orders", 0.04,
                                      CustomColors.customWhite),
                                );
                              } else {
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    setState(() {});
                                  },
                                  child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (snapshot.data[index]["delorderstatus"]
                                              .toString() ==
                                          "delivered") {
                                        return activeOrderCard(
                                          context,
                                          snapshot.data,
                                          index,
                                          setState,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                );
                              }
                            } else {
                              return const Loader();
                            }
                          },
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget activeOrderCard(BuildContext context, snapshot, index, setState) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 0.4),
    padding: EdgeInsets.symmetric(
      horizontal: CustomSizes().dynamicWidth(context, 0.05),
      vertical: CustomSizes().dynamicHeight(context, 0.01),
    ),
    margin: EdgeInsets.symmetric(
      horizontal: CustomSizes().dynamicWidth(context, 0.04),
      vertical: CustomSizes().dynamicHeight(context, 0.01),
    ),
    decoration: BoxDecoration(
      color: CustomColors.customLiteBlack,
      borderRadius: BorderRadius.circular(
        CustomSizes().dynamicWidth(context, 0.04),
      ),
      border: Border.all(
        color: CustomColors.customOrange,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text(
              context,
              "Order No: ${snapshot[index]["sale_no"].toString()}",
              .04,
              CustomColors.customWhite,
              bold: true,
            ),
            text(
              context,
              "Time: ${snapshot[index]["order_time"].toString()}",
              .04,
              CustomColors.customWhite,
              bold: true,
            ),
          ],
        ),
        text(
          context,
          (snapshot[index]["delorderstatus"].toString() == "pending" ||
                  snapshot[index]["delorderstatus"].toString() == "null" ||
                  snapshot[index]["delorderstatus"].toString().isEmpty)
              ? "Current Status: New Order to pick"
              : snapshot[index]["delorderstatus"].toString() == "On the way"
                  ? "Current Status: Order is on the way"
                  : "Current Status: Delivered",
          .04,
          (snapshot[index]["delorderstatus"].toString() == "pending" ||
                  snapshot[index]["delorderstatus"].toString() == "null" ||
                  snapshot[index]["delorderstatus"].toString().isEmpty)
              ? CustomColors.customRed
              : CustomColors.customGreen,
          bold: true,
        ),
        Row(
          children: [
            text(
              context,
              "Customer Phone: ${snapshot[index]["customer"][0]["phone"].toString()}",
              .04,
              CustomColors.customWhite,
              bold: true,
            ),
            CustomSizes().widthBox(context, .1),
            InkWell(
              onTap: () async {
                await canLaunch(
                        "tel:${snapshot[index]["customer"][0]["phone"].toString()}")
                    ? await launch(
                        "tel:${snapshot[index]["customer"][0]["phone"].toString()}")
                    : throw 'Could not launch ${snapshot[index]["customer"][0]["phone"].toString()}';
              },
              child: const CircleAvatar(
                backgroundColor: CustomColors.customBlack,
                child: Icon(Icons.phone),
              ),
            ),
          ],
        ),
        text(
          context,
          "Cooking Status: -----",
          .04,
          CustomColors.customWhite,
        ),
        text(
          context,
          "Customer Name: ${snapshot[index]["customer"][0]["name"].toString()}",
          .04,
          CustomColors.customWhite,
        ),
        text(
          context,
          "Amount: PKR ${double.parse(snapshot[index]["sub_total_with_discount"]).toStringAsFixed(0)}",
          0.04,
          CustomColors.customWhite,
          bold: true,
        ),
        text(
          context,
          "Payment Status: ${snapshot[index]["sub_total_with_discount"].toString()}",
          0.04,
          CustomColors.customWhite,
          bold: true,
        ),
        text(
          context,
          "Address: ${snapshot[index]["customer"][0]["address"].toString()}",
          0.04,
          CustomColors.customWhite,
          bold: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            coloredButton(
                context,
                "Items (${snapshot[index]["details"].length.toString()})",
                CustomColors.customOrange,
                width: CustomSizes().dynamicWidth(context, .36), function: () {
              CustomRoutes().push(
                context,
                OrderSummaryPage(
                  dataDetails: snapshot,
                  index: index,
                ),
              );
            }),
            coloredButton(context, "Pick", CustomColors.customOrange,
                width: CustomSizes().dynamicWidth(context, .36), function: () {
              CustomRoutes().push(
                context,
                OrderSummaryPage(
                  dataDetails: snapshot,
                  index: index,
                ),
              );
            }),
          ],
        ),
      ],
    ),
  );
}
