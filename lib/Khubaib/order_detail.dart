import 'package:baranh_rider/Khubaib/rating.dart';
import 'package:baranh_rider/Khubaib/submit_order.dart';
import 'package:baranh_rider/Screens/order_summary_page.dart';
import 'package:baranh_rider/backend/orders.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Screens/login.dart';
import '../Widgets/launch_camera.dart';
import '../Widgets/text_widget.dart';
import '../utils/app_routes.dart';
import '../utils/config.dart';
import '../utils/dynamic_sizes.dart';

class OrderDetail extends StatefulWidget {
  final List snapshot;
  final int index;
  final Function stateChange;
  const OrderDetail(
      {Key? key,
      required this.snapshot,
      required this.index,
      required this.stateChange})
      : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _buttonController1 =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customBlack,
      appBar: customAppbar(
        context: context,
        text1: "Order " + widget.snapshot[widget.index]["sale_no"].toString(),
        automaticallyImplyLeading: true,
        backgroundColor: CustomColors.customOrange,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: false,
              //  widget.snapshot[widget.index]["delorderstatus"] ==
              //         "delivered"
              //     ? false
              //     : widget.snapshot[widget.index]["delorderstatus"] == "pending"
              //         ? false
              //         : true,
              child: RoundedLoadingButton(
                color: CustomColors.customOrange,
                controller: _buttonController1,
                onPressed: () async {
                  final cameras = await availableCameras();
                  final firstCamera = cameras.first;
                  CustomRoutes().push(
                      context,
                      TakePictureScreen(
                        camera: firstCamera,
                        snapshot: widget.snapshot,
                        index: widget.index,
                      ));
                  _buttonController1.reset();
                },
                child: text(
                    context, "Undelivered", 0.04, CustomColors.customWhite),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible:
                  widget.snapshot[widget.index]["delorderstatus"] == "delivered"
                      ? false
                      : true,
              child: RoundedLoadingButton(
                color: CustomColors.customOrange,
                child: text(
                    context,
                    widget.snapshot[widget.index]["delorderstatus"] ==
                                "pending" ||
                            widget.snapshot[widget.index]["delorderstatus"] ==
                                null
                        ? "Picked"
                        : "Delivered",
                    0.04,
                    CustomColors.customWhite),
                onPressed: () async {
                  var res = await RiderFunctionality().setOrderStatus(
                      widget.snapshot[widget.index]["sale_no"],
                      "not at home",
                      widget.snapshot[widget.index]["delorderstatus"] ==
                                  "pending" ||
                              widget.snapshot[widget.index]["delorderstatus"] ==
                                  null
                          ? "0"
                          : "1",
                      widget.snapshot[widget.index]["delorderstatus"] ==
                                  "pending" ||
                              widget.snapshot[widget.index]["delorderstatus"] ==
                                  null
                          ? "proceed"
                          : "deliver");
                  if (res == false) {
                    _buttonController.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(
                            context,
                            "Check your internt or tey again",
                            0.04,
                            CustomColors.customWhite)));
                  } else {
                    _buttonController.reset();

                    Navigator.pop(context, widget.stateChange());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: text(context, "Success", 0.04,
                            CustomColors.customWhite)));
                  }
                },
                controller: _buttonController,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizes().heightBox(context, 0.05),
          personCard(context,
              phoneIcon: true,
              containerColor: false,
              name: widget.snapshot[widget.index]["customer"][0]["name"]
                  .toString(),
              phone: widget.snapshot[widget.index]["customer"][0]["phone"]
                  .toString()),
          CustomSizes().heightBox(context, 0.05),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CustomSizes().dynamicWidth(context, .05),
            ),
            child: text(context, "Info", 0.035, CustomColors.customGrey,
                bold: true),
          ),
          CustomSizes().heightBox(context, 0.025),
          orderBox(context, "Order Time",
              widget.snapshot[widget.index]["order_time"].toString()),
          CustomSizes().heightBox(context, 0.025),
          InkWell(
            onTap: () {
              CustomRoutes().push(
                  context,
                  OrderSummaryPage(
                    dataDetails: widget.snapshot,
                    index: widget.index,
                  ));
            },
            child: orderBox(
                context,
                "Total items",
                widget.snapshot[widget.index]["details"].length.toString() +
                    " Items"),
          ),
          CustomSizes().heightBox(context, 0.025),
          orderCard(
              context,
              "B",
              widget.snapshot[widget.index]["customer"][0]["address"]
                  .toString(),
              widget.snapshot[widget.index]["customer"][0]["phone"].toString(),
              icon: true),
        ],
      ),
    );
  }
}

Widget orderBox(context, title, title1) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 0.06),
    padding: EdgeInsets.symmetric(
      horizontal: CustomSizes().dynamicWidth(context, .05),
    ),
    color: CustomColors.customGrey.withOpacity(0.2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(context, title, 0.035, CustomColors.customGrey, bold: true),
        text(context, title1, 0.035, CustomColors.customWhite, bold: true),
      ],
    ),
  );
}
