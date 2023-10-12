// import 'package:flutter_test/flutter_test.dart';

// import 'package:splashpage_package/splashpage_package.dart';

// void main() {
//   test('adds one to input values', () {
//     final calculator = Calculator();
//     expect(calculator.addOne(2), 3);
//     expect(calculator.addOne(-7), -6);
//     expect(calculator.addOne(0), 1);
//   });
// }


// Container(
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SlideTransition(
//             position: _offsetAnimation,
//             child: Container(
//               height: 100,
//               width: 100,
//               child: Image(
//                 image: NetworkImage(widget.images),
//                 fit: BoxFit.fitHeight,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               return SlideTransition(
//                   textDirection: TextDirection.rtl,
//                   position: _offsetAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: FadeTransition(
//                       opacity: Tween<double>(begin: 0.0, end: 1.0)
//                           .animate(_controller),
//                       child: Text(
//                         widget.text,
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ));
//             },
//           ),
//         ],
//       ),
//     );