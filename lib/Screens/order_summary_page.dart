import 'package:baranh_rider/Screens/login.dart';
import 'package:baranh_rider/utils/config.dart';
import 'package:baranh_rider/utils/dynamic_sizes.dart';
import 'package:flutter/material.dart';

import '../Widgets/text_widget.dart';

class OrderSummaryPage extends StatefulWidget {
  final dynamic dataDetails;
  final dynamic index;

  const OrderSummaryPage({Key? key, this.dataDetails, this.index})
      : super(key: key);

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const BottomBannerAd(),
      backgroundColor: CustomColors.customBlack,
      appBar: customAppbar(
          context: context,
          text1: "Order Summary",
          automaticallyImplyLeading: true,
          backgroundColor: CustomColors.customOrange),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: CustomSizes().dynamicWidth(context, 0.05)),
        child: Column(
          children: [
            CustomSizes().heightBox(context, 0.02),
            Expanded(
                child: orderDetails(context, widget.dataDetails, widget.index))
          ],
        ),
      ),
    );
  }
}

billRow(context, text1, text2, size, color) {
  return Column(
    children: [
      const Divider(
        thickness: 1,
        color: CustomColors.customWhite,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(context, text1, size, color),
          text(context, text2, size, color),
        ],
      ),
      const Divider(
        thickness: 1,
        color: CustomColors.customWhite,
      ),
    ],
  );
}

orderDetails(context, snapshot, index) {
  return Column(
    children: [
      CustomSizes().heightBox(context, 0.05),
      text(context, "ORDER DETAILS #" + snapshot[index]["sale_no"].toString(),
          0.05, CustomColors.customWhite),
      const Divider(
        thickness: 1,
        color: CustomColors.customWhite,
      ),
      CustomSizes().heightBox(context, 0.05),
      (snapshot[index]["details"].length == 0)
          ? text(
              context,
              "No items ordered yet!",
              0.04,
              CustomColors.customWhite,
            )
          : Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot[index]["details"].length,
                itemBuilder: (BuildContext context, int index2) {
                  return viewOrderCard(
                    context,
                    snapshot[index]["details"],
                    index2,
                  );
                },
              ),
            ),
      CustomSizes().heightBox(context, 0.02),
      billRow(
        context,
        "Total 5% GST: ",
        "PKR " +
            ((double.parse(snapshot[index]["sub_total_with_discount"]) * 0.05) +
                    double.parse(snapshot[index]["sub_total_with_discount"]))
                .toStringAsFixed(2),
        0.03,
        CustomColors.customWhite,
      ),
      billRow(
        context,
        "Total 16% GST: ",
        "PKR " +
            ((double.parse(snapshot[index]["sub_total_with_discount"]) * 0.16) +
                    double.parse(snapshot[index]["sub_total_with_discount"]))
                .toStringAsFixed(2),
        0.03,
        CustomColors.customWhite,
      ),
      CustomSizes().heightBox(context, 0.02),
    ],
  );
}

viewOrderCard(context, snapshot, index) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: CustomSizes().dynamicHeight(context, 0.01),
    ),
    height: CustomSizes().dynamicHeight(context, .064),
    decoration: BoxDecoration(
      color: CustomColors.noColor,
      borderRadius: BorderRadius.circular(
        CustomSizes().dynamicWidth(context, 0.02),
      ),
      border: Border.all(
        color: CustomColors.customWhite,
      ),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: CustomSizes().dynamicWidth(context, .02),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(
              context,
              "${index + 1}. ",
              0.03,
              CustomColors.customWhite,
              alignText: TextAlign.center,
            ),
          ],
        ),
        CustomSizes().widthBox(context, .04),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.02),
              ),
              child: text(
                context,
                snapshot[index]["menu_name"].toString(),
                0.03,
                CustomColors.customWhite,
                alignText: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.02),
              ),
              child: text(
                context,
                "Rs ." +
                    snapshot[index]["menu_unit_price"] +
                    " x " +
                    snapshot[index]["qty"].toString(),
                0.03,
                CustomColors.customWhite,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
