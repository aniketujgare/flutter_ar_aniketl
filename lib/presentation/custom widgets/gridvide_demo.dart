// /*this file is responsible for making the grid view of 
// the animal cards in the 3d model menu option. 
// This view will generate the card automatically by taking the number fom the database 
// and then passing it here in the item count. 
// */

// import 'package:flutter/material.dart';
// import 'package:login_page/custom%20widgets/model_card.dart';

// class GridViewCard extends StatelessWidget {
//   const GridViewCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 20.0,
//         mainAxisSpacing: 20,
//         //childAspectRatio: MediaQuery.of(context).size.width * 0.
//       ),
//       itemCount: 6,
//       itemBuilder: (context, index) {
//         return ModelCard();
//       },
//     );
//   }
// }
