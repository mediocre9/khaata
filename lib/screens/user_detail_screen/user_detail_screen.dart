// import 'package:flutter/material.dart';
// import 'package:khata/constants.dart';
// import 'package:khata/models/model/order_model.dart';
// import 'package:khata/models/model/product_model.dart';
// import 'package:khata/screens/order_screen/order_screen.dart';
// import 'package:khata/widgets/custom_app_bar.dart';
// import 'package:khata/widgets/custom_card.dart';
// import 'package:khata/widgets/custom_drawer.dart';
// import 'package:khata/widgets/custom_outlined_button.dart';

// class UserDetailScreen extends StatefulWidget {
//   const UserDetailScreen({
//     Key? key,
//     this.username,
//     this.index,
//     this.totalOrders,
//   }) : super(key: key);
  
//   final String? username, totalOrders;
//   final int? index;

//   @override
//   State<UserDetailScreen> createState() => _UserDetailScreenState();
// }

// class _UserDetailScreenState extends State<UserDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: CustomAppBar(
//           title: "Order",
//           titleFontSize: 23,
//           subTitle: "Book",
//         ),

//         // Drawer
//         endDrawer: const CustomDrawer(),
//         body: SafeArea(
//           child: Center(
//             child: CustomCard(
//               innerMainAlignment: MainAxisAlignment.start,
//               innerCrossAlignment: CrossAxisAlignment.start,
//               width: double.maxFinite,
//               shadow: true,
//               height: 340,
//               verticalMargin: 5,
//               horizontalMargin: 30,
//               elevationLevel: 5,
//               borderRadius: 5,
//               child: Container(
//                 padding: const EdgeInsets.only(left: 30, right: 8, top: 2),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           color: Colors.white60,
//                           icon: const Icon(Icons.close_outlined),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                     Container(
//                       padding: const EdgeInsets.only(bottom: 30, left: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.product!,
//                             style: const TextStyle(
//                               color: Color.fromARGB(255, 218, 224, 236),
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 3),
//                           Text(
//                             "RS. ${widget.cost!.replaceAll("PKR", "")}",
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 3),
//                           Text(
//                             widget.username!,
//                             style: const TextStyle(
//                               color: Color.fromARGB(255, 218, 224, 236),
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       "STATUS : ${orderBox!.getAt(widget.index!)!.status! ? "COMPLETED" : "PENDING"}",
//                       style: const TextStyle(
//                           color: Color.fromARGB(255, 218, 224, 236),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       "CREATED DATE : ${widget.createdDate!.replaceAll(" 00:00:00.000", "")}",
//                       style: const TextStyle(
//                           color: Color.fromARGB(255, 218, 224, 236),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       "COMPLETED DATE : ${widget.completedDate!.replaceAll(" 00:00:00.000", "")}",
//                       style: const TextStyle(
//                           color: Color.fromARGB(255, 218, 224, 236),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           orderBox!.getAt(widget.index!)!.status! == false
//                               ? CustomOutlinedButton(
//                                   textColor:
//                                       const Color.fromARGB(255, 218, 224, 236),
//                                   text: "MARK COMPLETED",
//                                   onPressed: () {
//                                     setState(
//                                       () {
//                                         // orderBox!.deleteAt(widget.index!);

//                                         for (var i = 0;
//                                             i < productBox!.values.length;
//                                             i++) {
//                                           // product exists...
//                                           if (productBox!
//                                                   .getAt(i)!
//                                                   .name!
//                                                   .toLowerCase() ==
//                                               widget.product!.toLowerCase()) {
//                                             // then decrease stock....
//                                             int currentStock = productBox!
//                                                     .getAt(i)!
//                                                     .initialStock! -
//                                                 1;

//                                             // get object
//                                             var product = productBox!.getAt(i);

//                                             // show alert when item is less than 5....
//                                             if (productBox!
//                                                     .getAt(i)!
//                                                     .initialStock! <=
//                                                 5) {
//                                               _showDialog("Alert",
//                                                   "Product ${productBox!.getAt(i)!.name!.toLowerCase()} stock is ${productBox!.getAt(i)!.initialStock!}");

//                                               // update description....
//                                               orderBox!.putAt(
//                                                 widget.index!,
//                                                 OrderModel(
//                                                   widget.username,
//                                                   widget.product,
//                                                   int.parse(widget.cost!
//                                                       .replaceAll(" PKR", "")),
//                                                   DateTime.parse(
//                                                       widget.createdDate!),
//                                                   DateTime.parse(DateTime.now()
//                                                       .toString()),
//                                                   true,
//                                                 ),
//                                               );

//                                               // update item
//                                               productBox!.putAt(
//                                                 i,
//                                                 ProductModel(
//                                                   name: product!.name,
//                                                   initialStock: currentStock,
//                                                   cost: int.parse(widget.cost!
//                                                       .replaceAll(" PKR", "")),
//                                                 ),
//                                               );

//                                               // go back
//                                               Navigator.pushAndRemoveUntil(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         const ManageOrderScreen(),
//                                                   ),
//                                                   (route) => false);
//                                             }
//                                             // show alert when item is out of stock....
//                                             // else if (productBox!
//                                             //         .getAt(i)!
//                                             //         .initialStock! ==
//                                             //     0) {
//                                             //   _showDialog(
//                                             //     "Alert",
//                                             //     "Product ${productBox!.getAt(i)!.name!.toLowerCase()} is out of stock. Please refill your inventory.",
//                                             //   );
//                                             // }
//                                             else {
//                                               // update item
//                                               productBox!.putAt(
//                                                 i,
//                                                 ProductModel(
//                                                   name: product!.name,
//                                                   initialStock: currentStock,
//                                                   cost: int.parse(widget.cost!
//                                                       .replaceAll(" PKR", "")),
//                                                 ),
//                                               );

//                                               // updated description....
//                                               orderBox!.putAt(
//                                                 widget.index!,
//                                                 OrderModel(
//                                                   widget.username,
//                                                   widget.product,
//                                                   int.parse(widget.cost!
//                                                       .replaceAll(" PKR", "")),
//                                                   DateTime.parse(
//                                                       widget.createdDate!),
//                                                   DateTime.parse(DateTime.now()
//                                                       .toString()),
//                                                   true,
//                                                 ),
//                                               );

//                                               Navigator.pushAndRemoveUntil(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         const ManageOrderScreen(),
//                                                   ),
//                                                   (route) => false);
//                                             }

//                                             // update inventory item....
//                                             // else {
//                                             // productBox!.putAt(
//                                             //   i,
//                                             //   ProductModel(
//                                             //     name: product!.name,
//                                             //     initialStock: currentStock,
//                                             //     cost: int.parse(widget.cost!
//                                             //         .replaceAll(" PKR", "")),
//                                             //   ),
//                                             // );
//                                             // }

//                                             // Navigator.pushAndRemoveUntil(
//                                             //     context,
//                                             //     MaterialPageRoute(
//                                             //       builder: (context) =>
//                                             //           const ManageOrderScreen(),
//                                             //     ),
//                                             //     (route) => false);
//                                           }
//                                         }
//                                       },
//                                     );
//                                   },
//                                 )
//                               : Container(),
//                           const SizedBox(height: 9),
//                           CustomOutlinedButton(
//                             text: "DELETE",
//                             borderColor: Colors.redAccent,
//                             textColor: Colors.redAccent,
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: const Text("Warning!"),
//                                     content: const Text(
//                                         "Do you really want to delete this record?"),
//                                     actions: [
//                                       TextButton(
//                                         child: const Text("Yes"),
//                                         onPressed: () {
//                                           orderBox!.deleteAt(widget.index!);
//                                           Navigator.pushAndRemoveUntil(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     const ManageOrderScreen(),
//                                               ),
//                                               (route) => false);
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(
//                                             SnackBar(
//                                               key: UniqueKey(),
//                                               content: const Text(
//                                                   "Item deleted!",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w600)),
//                                               backgroundColor:
//                                                   kSnackBarErrorColor,
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                       TextButton(
//                                           onPressed: () =>
//                                               Navigator.pop(context),
//                                           child: const Text("Cancel")),
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future _showDialog(String? title, String? description) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(title!),
//           content: Text(description!),
//           actions: [
//             TextButton(
//               child: const Text("Ok"),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
