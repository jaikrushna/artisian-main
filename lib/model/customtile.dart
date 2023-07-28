// import 'package:flutter/material.dart';
//
// class GradientButton extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   final String subtitle;
//   final Gradient gradient;
//   final VoidCallback onPressed;
//
//   GradientButton({
//     required this.imagePath,
//     required this.title,
//     required this.subtitle,
//     required this.gradient,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: gradient,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: onPressed,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 10,
//                     child: Image.asset(
//                       imagePath,
//                       width: 4,
//                       height: 40,
//                     ),
//                   ),
//                   SizedBox(width: 8.0),
//                   Column(
//                     children: [
//                       Text(
//                         title,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 4.0),
//                       Text(
//                         subtitle,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Gradient gradient;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  late Animation<double> animation;
  CustomTile({
    required this.gradient,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      isTicked
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: isTicked
                          ? Colors.green
                          : Colors.grey, // Change the color as needed.
                      size: 24.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
