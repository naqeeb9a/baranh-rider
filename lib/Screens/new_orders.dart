
import 'package:flutter/material.dart';

import '../Khubaib/book_courier.dart';
import '../utils/app_routes.dart';
import '../utils/config.dart';
import '../utils/dynamic_sizes.dart';

class NewOrders extends StatefulWidget {
  const NewOrders({Key? key}) : super(key: key);

  @override
  State<NewOrders> createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "New Order type"),
          CustomSizes().heightBox(context, 0.01),
          cards(
            context,
            Icons.book,
            "Book a courier",
            false,
            function: () {
              CustomRoutes().push(
                context,
                const BookCourier(),
              );
            },
          ),
          CustomSizes().heightBox(context, 0.01),
          cards(context, Icons.location_city, "Hyperlocal", false)
        ],
      ),
    );
  }
}

cards(context, icon, text, check, {check2 = false, function = ""}) {
  return InkWell(
    onTap: function == "" ? () {} : function,
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.all(CustomSizes().dynamicWidth(context, 0.03)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding:
                    EdgeInsets.all(CustomSizes().dynamicWidth(context, 0.02)),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: check == false ? Colors.grey : Colors.transparent,
                      width: check == false ? 1 : 0),
                  borderRadius: BorderRadius.circular(
                    CustomSizes().dynamicWidth(context, 0.02),
                  ),
                ),
                child: Icon(
                  icon,
                  color: CustomColors.customYellow,
                ),
              ),
              CustomSizes().widthBox(context, 0.03),
              Text(text)
            ],
          ),
          check2 == true
              ? const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                )
              : Container(),
        ],
      ),
    ),
  );
}

topBar(context, text) {
  return Container(
    padding: EdgeInsets.only(
      top: CustomSizes().dynamicWidth(context, 0.12),
      left: CustomSizes().dynamicWidth(context, 0.05),
      right: CustomSizes().dynamicWidth(context, 0.05),
      bottom: CustomSizes().dynamicWidth(context, 0.04),
    ),
    color: CustomColors.customYellow,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => CustomRoutes().pop(context),
          child: CircleAvatar(
            radius: CustomSizes().dynamicWidth(context, 0.035),
            backgroundColor: Colors.white.withOpacity(0.3),
            child: Icon(
              Icons.arrow_back_ios,
              size: CustomSizes().dynamicWidth(context, 0.03),
              color: Colors.white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        CircleAvatar(
          radius: CustomSizes().dynamicWidth(context, 0.035),
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.arrow_back_ios,
            size: CustomSizes().dynamicWidth(context, 0.03),
            color: Colors.transparent,
          ),
        ),
      ],
    ),
  );
}
