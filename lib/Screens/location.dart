import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../Khubaib/preferences.dart';
import '../Khubaib/submit_order.dart';
import '../Khubaib/track_order.dart';
import '../Widgets/colorful_button.dart';
import '../Widgets/text_widget.dart';
import '../utils/app_routes.dart';
import '../utils/config.dart';
import '../utils/dynamic_sizes.dart';
import 'new_orders.dart';

class LocationDetails extends StatefulWidget {
  const LocationDetails({Key? key}) : super(key: key);

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: orderBottomBar(
        context,
        "Next",
        function: () => CustomRoutes().push(
          context,
          const PreferencesScreen(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            topBar(context, "Location Details"),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: CustomSizes().dynamicHeight(context, .02),
                horizontal: CustomSizes().dynamicWidth(context, .04),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: CustomSizes().dynamicHeight(context, .02),
                    backgroundColor: CustomColors.customOrange,
                    child: Center(
                      child: text(
                        context,
                        "1",
                        .05,
                        CustomColors.customWhite,
                        bold: true,
                      ),
                    ),
                  ),
                  CustomSizes().widthBox(context, .04),
                  text(
                    context,
                    "Pickup Point",
                    .05,
                    CustomColors.customBlack,
                    bold: true,
                  ),
                ],
              ),
            ),
            ColoredBox(
              color: CustomColors.customWhite,
              child: Row(
                children: [
                  Flexible(
                    child: trackTextField(context, "Address", border: false),
                  ),
                  CustomSizes().widthBox(context, .02),
                  const Icon(
                    Icons.lock,
                    color: CustomColors.customOrange,
                  ),
                  CustomSizes().widthBox(context, .04),
                ],
              ),
            ),
            CustomSizes().heightBox(context, .03),
            ColoredBox(
              color: CustomColors.customWhite,
              child: Row(
                children: [
                  Flexible(
                    child: trackTextField(context, "Your Phone", border: false),
                  ),
                  CustomSizes().widthBox(context, .02),
                  const Icon(
                    Icons.phone_android_rounded,
                    color: CustomColors.customOrange,
                  ),
                  CustomSizes().widthBox(context, .04),
                ],
              ),
            ),
            CustomSizes().heightBox(context, .03),
            Container(
              width: CustomSizes().dynamicWidth(context, 1),
              height: CustomSizes().dynamicHeight(context, .12),
              color: CustomColors.customWhite,
              padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, .05),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  text(
                    context,
                    "When to arrive at this address",
                    .036,
                    CustomColors.customGrey,
                  ),
                  Center(
                    child: Container(
                      width: CustomSizes().dynamicWidth(context, .84),
                      height: CustomSizes().dynamicHeight(context, .06),
                      decoration: BoxDecoration(
                        color: CustomColors.customGrey.withOpacity(.24),
                        borderRadius: BorderRadius.circular(
                          CustomSizes().dynamicWidth(context, .02),
                        ),
                        border: Border.all(
                          color: CustomColors.customGrey,
                        ),
                      ),
                      padding: EdgeInsets.all(
                        CustomSizes().dynamicHeight(context, .004),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomDropdownButton2(
                            hint: 'Item 1',
                            value: selectedValue,
                            dropdownItems: items,
                            buttonWidth:
                                CustomSizes().dynamicWidth(context, .34),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: CustomSizes().dynamicWidth(context, .06),
                            ),
                            buttonDecoration: BoxDecoration(
                              color: CustomColors.customWhite,
                              borderRadius: BorderRadius.circular(
                                CustomSizes().dynamicWidth(context, .02),
                              ),
                              border: Border.all(
                                color: CustomColors.customGrey,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                          text(context, "-", .044, CustomColors.customBlack),
                          CustomDropdownButton2(
                            hint: 'Item 1',
                            value: selectedValue,
                            dropdownItems: items,
                            buttonWidth:
                                CustomSizes().dynamicWidth(context, .34),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: CustomSizes().dynamicWidth(context, .06),
                            ),
                            buttonDecoration: BoxDecoration(
                              color: CustomColors.customWhite,
                              borderRadius: BorderRadius.circular(
                                CustomSizes().dynamicWidth(context, .02),
                              ),
                              border: Border.all(
                                color: CustomColors.customGrey,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomSizes().heightBox(context, .03),
            ColoredBox(
              color: CustomColors.customWhite,
              child: trackTextField(context, "Comment", border: false),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: CustomSizes().dynamicHeight(context, .02),
                horizontal: CustomSizes().dynamicWidth(context, .04),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: CustomSizes().dynamicHeight(context, .02),
                    backgroundColor: CustomColors.customOrange,
                    child: Center(
                      child: text(
                        context,
                        "2",
                        .05,
                        CustomColors.customWhite,
                        bold: true,
                      ),
                    ),
                  ),
                  CustomSizes().widthBox(context, .04),
                  text(
                    context,
                    "Delivery Point",
                    .05,
                    CustomColors.customBlack,
                    bold: true,
                  ),
                ],
              ),
            ),
            ColoredBox(
              color: CustomColors.customWhite,
              child: Row(
                children: [
                  Flexible(
                    child: trackTextField(context, "Address", border: false),
                  ),
                  CustomSizes().widthBox(context, .02),
                  const Icon(
                    Icons.lock,
                    color: CustomColors.customOrange,
                  ),
                  CustomSizes().widthBox(context, .04),
                ],
              ),
            ),
            CustomSizes().heightBox(context, .03),
            ColoredBox(
              color: CustomColors.customWhite,
              child: Row(
                children: [
                  Flexible(
                    child: trackTextField(context, "Your Phone", border: false),
                  ),
                  CustomSizes().widthBox(context, .02),
                  const Icon(
                    Icons.phone_android_rounded,
                    color: CustomColors.customOrange,
                  ),
                  CustomSizes().widthBox(context, .04),
                ],
              ),
            ),
            CustomSizes().heightBox(context, .03),
            Container(
              width: CustomSizes().dynamicWidth(context, 1),
              height: CustomSizes().dynamicHeight(context, .12),
              color: CustomColors.customWhite,
              padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, .05),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  text(
                    context,
                    "When to arrive at this address",
                    .036,
                    CustomColors.customGrey,
                  ),
                  Center(
                    child: Container(
                      width: CustomSizes().dynamicWidth(context, .84),
                      height: CustomSizes().dynamicHeight(context, .06),
                      decoration: BoxDecoration(
                        color: CustomColors.customGrey.withOpacity(.24),
                        borderRadius: BorderRadius.circular(
                          CustomSizes().dynamicWidth(context, .02),
                        ),
                        border: Border.all(
                          color: CustomColors.customGrey,
                        ),
                      ),
                      padding: EdgeInsets.all(
                        CustomSizes().dynamicHeight(context, .004),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomDropdownButton2(
                            hint: 'Item 1',
                            value: selectedValue,
                            dropdownItems: items,
                            buttonWidth:
                                CustomSizes().dynamicWidth(context, .34),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: CustomSizes().dynamicWidth(context, .06),
                            ),
                            buttonDecoration: BoxDecoration(
                              color: CustomColors.customWhite,
                              borderRadius: BorderRadius.circular(
                                CustomSizes().dynamicWidth(context, .02),
                              ),
                              border: Border.all(
                                color: CustomColors.customGrey,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                          text(context, "-", .044, CustomColors.customBlack),
                          CustomDropdownButton2(
                            hint: 'Item 1',
                            value: selectedValue,
                            dropdownItems: items,
                            buttonWidth:
                                CustomSizes().dynamicWidth(context, .34),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: CustomSizes().dynamicWidth(context, .06),
                            ),
                            buttonDecoration: BoxDecoration(
                              color: CustomColors.customWhite,
                              borderRadius: BorderRadius.circular(
                                CustomSizes().dynamicWidth(context, .02),
                              ),
                              border: Border.all(
                                color: CustomColors.customGrey,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomSizes().heightBox(context, .03),
            ColoredBox(
              color: CustomColors.customWhite,
              child: trackTextField(context, "Comment", border: false),
            ),
            CustomSizes().heightBox(context, .03),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.05)),
              child: colorfulButton(
                context,
                "Add Delivery Point",
                CustomColors.customOrange,
                CustomColors.customOrange,
                FontWeight.bold,
                // function: () {
                //   CustomRoutes().push(context, const TrackDetail());
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
