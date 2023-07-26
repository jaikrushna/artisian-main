// import 'package:flutter/material.dart';
// // import 'package:carousel_slider/carousel_slider.dart';
//
// class CarouselSliderExample extends StatefulWidget {
//   @override
//   _CarouselSliderExampleState createState() => _CarouselSliderExampleState();
// }
//
// class _CarouselSliderExampleState extends State<CarouselSliderExample> {
//   List<String> images = [
//     "https://images.pexels.com/photos/1191403/pexels-photo-1191403.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     "https://images.pexels.com/photos/9020063/pexels-photo-9020063.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     "https://images.pexels.com/photos/12437389/pexels-photo-12437389.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     "https://images.pexels.com/photos/58997/pexels-photo-58997.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         aspectRatio: 16 / 9,
//         viewportFraction: 0.8,
//         enlargeCenterPage: true,
//         autoPlay: true,
//       ),
//       items: images
//           .map((item) => Container(
//                 child: Center(
//                   child: Image.network(
//                     item,
//                     fit: BoxFit.cover,
//                     width: 1000,
//                   ),
//                 ),
//               ))
//           .toList(),
//     );
//   }
// }

// class CarouselSliderExample extends StatefulWidget {
//   const CarouselSliderExample({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _CarouselSliderExampleState createState() => _CarouselSliderExampleState();
// }
//
// class _CarouselSliderExampleState extends State<CarouselSliderExample> {
//   List<String> images = [
//     "https://images.pexels.com/photos/1191403/pexels-photo-1191403.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     "https://images.pexels.com/photos/9020063/pexels-photo-9020063.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     "https://images.pexels.com/photos/12437389/pexels-photo-12437389.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     "https://images.pexels.com/photos/58997/pexels-photo-58997.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//         options: CarouselOptions(
//           aspectRatio: 16 / 9,
//           viewportFraction: 0.8,
//           enlargeCenterPage: true,
//           autoPlay: true,
//         ),
//         items: images
//             .map((item) => Container(
//           child: Center(
//             child: Image.network(
//               item,
//               fit: BoxFit.cover,
//               width: 1000,
//             ),
//           ),
//         ))
//             .toList(),
//     );
//   }
// }
// // Main page of the widget (Carousel)
// class CarouselScreen extends StatefulWidget {
//   const CarouselScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<CarouselScreen> createState() => _CarouselScreenState();
// }
//
// class _CarouselScreenState extends State<CarouselScreen> {
//   int activePage = 0;
//   late PageController _pageController;
//   List<String> images = [
//     "https://images.pexels.com/photos/1191403/pexels-photo-1191403.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     "https://images.pexels.com/photos/9020063/pexels-photo-9020063.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     "https://images.pexels.com/photos/12437389/pexels-photo-12437389.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     "https://images.pexels.com/photos/58997/pexels-photo-58997.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         aspectRatio: 16 / 9,
//         viewportFraction: 0.8,
//         enlargeCenterPage: true,
//         autoPlay: true,
//       ),
//       items: images
//           .map((item) => Container(
//                 child: Center(
//                   child: Image.network(
//                     item,
//                     fit: BoxFit.cover,
//                     width: 1000,
//                   ),
//                 ),
//               ))
//           .toList(),
//     );
//   }
// }

// // Animated container widget
// AnimatedContainer slider(images, pagePosition, active) {
//   double margin = active ? 10 : 20;
//
//   return AnimatedContainer(
//     duration: const Duration(milliseconds: 500),
//     curve: Curves.easeInOutCubic,
//     margin: EdgeInsets.all(margin),
//     decoration: BoxDecoration(
//       image: DecorationImage(
//         image: NetworkImage(
//           images[pagePosition],
//         ),
//         fit: BoxFit.cover,
//       ),
//     ),
//   );
// }
//
// // Widget for image animation while sliding carousel
// imageAnimation(PageController animation, images, pagePosition) {
//   return AnimatedBuilder(
//     animation: animation,
//     builder: (context, widget) {
//       print(pagePosition);
//       return SizedBox(
//         width: 200,
//         height: 200,
//         child: widget,
//       );
//     },
//     child: Container(
//       margin: const EdgeInsets.all(10),
//       child: Image.network(images[pagePosition]),
//     ),
//   );
// }
//
// // Widget for showing image indicator
// List<Widget> imageIndicator(imagesLength, currentIndex) {
//   return List<Widget>.generate(imagesLength, (index) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
//       width: 10,
//       height: 10,
//       decoration: BoxDecoration(
//         color: currentIndex == index ? Colors.teal.shade400 : Colors.black26,
//         shape: BoxShape.circle,
//       ),
//     );
//   });
// }
