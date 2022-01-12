// import 'package:flutter/material.dart';

// import '../../size_config.dart';

// class FilterPage extends StatefulWidget {
//   const FilterPage({Key? key}) : super(key: key);
//   static String routeName = "/productScreen";

//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
//   List<String> skinCategories = ["wella", "vedicline", "cacau", "raaga"];
//   List<String> toolsCategory = ["ikonic", "wahl"];
//   @override
//   Widget build(BuildContext context) {
//     final String ctg = ModalRoute.of(context)!.settings.arguments.toString();
//     SizeConfig().init(context);
//     return Scaffold(
//       body: Container(
//           child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 4.0,
//                   crossAxisSpacing: 4.0),
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   child: Center(
//                       child: Text(ctg == '1'
//                           ? skinCategories[index]
//                           : toolsCategory[index])),
//                 );
//               })),
//     );
//   }
// }
