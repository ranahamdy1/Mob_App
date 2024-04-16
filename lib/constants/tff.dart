// import 'package:flutter/material.dart';
//
// class CustomTFF extends StatelessWidget {
//   final String hintText;
//   final TextInputType kbType;
//   final TextEditingController controller;
//   final Icon? suffixIcon;
//   final Function? onSubmit;
//   final Function? onChange;
//   final Function? onTap;
//   final bool isPassword = false;
//   final dynamic validate;
//   const CustomTFF({
//     Key? key,
//     this.suffixIcon,
//     required this.hintText,
//     required this.kbType,
//     required this.controller,
//     this.onSubmit,
//     this.onChange,
//     this.onTap,
//     this.validate,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 40,
//       child: TextFormField(
//         decoration: InputDecoration(
//           suffixIcon: suffixIcon,
//           fillColor: Colors.white,
//           filled: true,
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(70),
//             borderSide: BorderSide(color: Colors.red, width: 1.5),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(70),
//             borderSide: BorderSide(color: Colors.red, width: 1.5),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(70),
//             borderSide: BorderSide(color: Colors.red, width: 1.5),
//           ),
//           border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(70)),
//               borderSide: BorderSide(color: Colors.grey)),
//           hintText: hintText,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//           hintStyle: const TextStyle(color: Colors.grey, fontFamily: "Inter"),
//         ),
//       ),
//     );
//   }
// }
