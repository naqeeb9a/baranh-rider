

// class ActiveOrder extends StatefulWidget {
//   const ActiveOrder({Key? key}) : super(key: key);
//
//   @override
//   _ActiveOrderState createState() => _ActiveOrderState();
// }
//
// class _ActiveOrderState extends State<ActiveOrder> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomColors.customBlack,
//       body: activeOrder(context, () {
//         setState(() {});
//       }),
//     );
//   }
// }
//
// Widget noActiverOrder(context) {
//   return Container(
//     width: CustomSizes().dynamicWidth(context, 1),
//     height: CustomSizes().dynamicHeight(context, 1),
//     color: CustomColors.customWhite.withOpacity(0.2),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         noactiveOrderCard(
//             context,
//             "https://www.pngkit.com/png/full/72-724560_png-file-tracking-parcel-png.png",
//             "Send Package",
//             "Deliver or recieve items such as gifts ,documents,keys",
//             CustomColors.customOrange),
//         CustomSizes().heightBox(context, 0.065),
//         noactiveOrderCard(
//             context,
//             "https://cdn0.iconfinder.com/data/icons/line-design-word-processing-set-3-1/21/mailing-recipient-list-512.png",
//             "I am Recipent",
//             "Track an incoming delivery in the app",
//             CustomColors.customBlack)
//       ],
//     ),
//   );
// }
//
// Widget noactiveOrderCard(context, image, title, subtitle, pngColor) {
//   return Container(
//     width: CustomSizes().dynamicWidth(context, 0.85),
//     height: CustomSizes().dynamicHeight(context, .15),
//     decoration: BoxDecoration(
//       color: CustomColors.customWhite,
//       borderRadius: BorderRadius.circular(
//         CustomSizes().dynamicWidth(context, 0.05),
//       ),
//     ),
//     child: Row(
//       children: [
//         SizedBox(
//           width: CustomSizes().dynamicWidth(context, 0.3),
//           height: CustomSizes().dynamicHeight(context, .1),
//           child: Image.network(
//             image,
//             color: pngColor,
//           ),
//         ),
//         Flexible(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               text(context, title, 0.045, CustomColors.customBlack, bold: true),
//               CustomSizes().heightBox(context, 0.02),
//               text(context, subtitle, 0.035, CustomColors.customGrey),
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }
//
// Widget activeOrder(context, setState) {
//   return SizedBox(
//     width: CustomSizes().dynamicWidth(context, 1),
//     height: CustomSizes().dynamicHeight(context, 1),
//     child: FutureBuilder(
//         future: RiderFunctionality().getRiderInfo(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.data == false) {
//               return retry(context);
//             } else if (snapshot.data.length == 0) {
//               return Center(
//                 child: text(context, "No Active Orders", 0.04,
//                     CustomColors.customWhite),
//               );
//             } else {
//               List pickedOrders = [];
//               List newOrders = [];
//               List deliveredOrders = [];
//               for (var item in snapshot.data) {
//                 if (item["delorderstatus"].toString() == "pending" ||
//                     item["delorderstatus"].toString() == "null" ||
//                     item["delorderstatus"].toString().isEmpty) {
//                   newOrders.add(item);
//                 } else if (item["delorderstatus"] == "delivered") {
//                   deliveredOrders.add(item);
//                 } else {
//                   pickedOrders.add(item);
//                 }
//               }
//               bool isSelected1 = true;
//               bool isSelected2 = false;
//               bool isSelected3 = false;
//               return StatefulBuilder(builder: (context, changeState) {
//                 return Column(
//                   children: [
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         ChoiceChip(
//                             backgroundColor: CustomColors.customBlack,
//                             selectedColor: CustomColors.customOrange,
//                             onSelected: (value) => changeState(() {
//                                   isSelected1 = value;
//                                   isSelected2 = false;
//                                   isSelected3 = false;
//                                 }),
//                             label: text(context, "New Orders", 0.03,
//                                 CustomColors.customWhite),
//                             selected: isSelected1),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         ChoiceChip(
//                             backgroundColor: CustomColors.customBlack,
//                             onSelected: (value) => changeState(() {
//                                   isSelected1 = false;
//                                   isSelected2 = value;
//                                   isSelected3 = false;
//                                 }),
//                             selectedColor: CustomColors.customOrange,
//                             label: text(context, "Picked Orders", 0.03,
//                                 CustomColors.customWhite),
//                             selected: isSelected2),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         ChoiceChip(
//                             backgroundColor: CustomColors.customBlack,
//                             onSelected: (value) => changeState(() {
//                                   isSelected1 = false;
//                                   isSelected2 = false;
//                                   isSelected3 = value;
//                                 }),
//                             selectedColor: CustomColors.customOrange,
//                             label: text(context, "Delivered Orders", 0.03,
//                                 CustomColors.customWhite),
//                             selected: isSelected3),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Expanded(
//                       child: isSelected1 == true &&
//                               isSelected2 == false &&
//                               isSelected3 == false
//                           ? text(context, "No New Orders", 0.04,
//                               CustomColors.customWhite)
//                           : isSelected2 == true &&
//                                   isSelected1 == false &&
//                                   isSelected3 == false
//                               ? text(context, "No Picked Orders", 0.04,
//                                   CustomColors.customWhite)
//                               : isSelected3 == true &&
//                                       isSelected1 == false &&
//                                       isSelected2 == false
//                                   ? text(context, "No completed Orders", 0.04,
//                                       CustomColors.customWhite)
//                                   : ListView.builder(
//                                       padding: EdgeInsets.symmetric(
//                                         vertical: CustomSizes()
//                                             .dynamicHeight(context, 0),
//                                       ),
//                                       itemCount: isSelected1 == true &&
//                                               isSelected2 == false &&
//                                               isSelected3 == false
//                                           ? newOrders.length
//                                           : isSelected2 == true &&
//                                                   isSelected1 == false &&
//                                                   isSelected3 == false
//                                               ? pickedOrders.length
//                                               : isSelected3 == true &&
//                                                       isSelected1 == false &&
//                                                       isSelected2 == false
//                                                   ? deliveredOrders.length
//                                                   : snapshot.data.length,
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         return activeOrderCard(
//                                             context,
//                                             isSelected1 == true &&
//                                                     isSelected2 == false
//                                                 ? newOrders
//                                                 : isSelected2 == true &&
//                                                         isSelected1 == false
//                                                     ? pickedOrders
//                                                     : snapshot.data,
//                                             index,
//                                             setState);
//                                       },
//                                     ),
//                     ),
//                   ],
//                 );
//               });
//             }
//           } else {
//             return const Loader();
//           }
//         }),
//   );
// }


