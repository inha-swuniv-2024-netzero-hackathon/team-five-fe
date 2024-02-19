// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:proto_just_design/class/detail_misiklist_class.dart';
// import 'package:proto_just_design/functions/default_function.dart';
// import 'package:proto_just_design/providers/detail_misiklist_provider.dart';
// import 'package:proto_just_design/providers/misiklist_page_provider.dart';
// import 'package:proto_just_design/widget_datas/default_color.dart';
// import 'package:provider/provider.dart';

// class MisiklistDetailBottomNavbar extends StatefulWidget {
//   const MisiklistDetailBottomNavbar({super.key});

//   @override
//   State<MisiklistDetailBottomNavbar> createState() =>
//       _MisiklistDetailBottomNavbarState();
// }

// class _MisiklistDetailBottomNavbarState
//     extends State<MisiklistDetailBottomNavbar> {
//   @override
//   Widget build(BuildContext context) {
//     MisikListDetail? misiklistdata =
//         context.watch<MisiklistDetailProvider>().misiklist;
//     return (misiklistdata != null)
//         ? Container(
//             height: 60,
//             alignment: Alignment.center,
//             decoration:
//                 const BoxDecoration(color: ColorStyles.white, boxShadow: [
//               BoxShadow(
//                 color: Color(0x19000000),
//                 blurRadius: 3,
//                 offset: Offset(0, -2),
//               )
//             ]),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () async {
//                       final check = await checkLogin(context);
//                       if (check) {
//                         if (mounted) {
//                           context.read<MisiklistDetailProvider>().setLike();
//                         }
//                         setState(() {});
//                       }
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           (context.watch<MisiklistDetailProvider>().isGood ==
//                                   true)
//                               ? Icons.thumb_up
//                               : Icons.thumb_up_outlined,
//                           color: (context
//                                       .watch<MisiklistDetailProvider>()
//                                       .isGood ==
//                                   true)
//                               ? ColorStyles.red
//                               : ColorStyles.black,
//                         ),
//                         const Gap(3),
//                         Text(
//                           '추천',
//                           style: TextStyle(
//                               color: (context
//                                           .watch<MisiklistDetailProvider>()
//                                           .isGood ==
//                                       true)
//                                   ? ColorStyles.red
//                                   : ColorStyles.black),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () async {
//                       final check = await checkLogin(context);
//                       if (check) {
//                         context.read<MisiklistDetailProvider>().setDislike();
//                         setState(() {});
//                       }
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           (context.watch<MisiklistDetailProvider>().isGood ==
//                                   true)
//                               ? Icons.thumb_down
//                               : Icons.thumb_down_outlined,
//                           color: (context
//                                       .watch<MisiklistDetailProvider>()
//                                       .isGood ==
//                                   false)
//                               ? ColorStyles.red
//                               : ColorStyles.black,
//                         ),
//                         const Gap(3),
//                         Text(
//                           '비추천',
//                           style: TextStyle(
//                               color: (context
//                                           .watch<MisiklistDetailProvider>()
//                                           .isGood ==
//                                       false)
//                                   ? ColorStyles.red
//                                   : ColorStyles.black),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.comment_outlined,
//                         color: ColorStyles.black,
//                       ),
//                       const Gap(3),
//                       Text(
//                         '댓글',
//                         style: TextStyle(color: ColorStyles.black),
//                       )
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () async {
//                       if (await checkLogin(context)) {
//                         if (mounted) {
//                           if (await setMisiklistBookmark(
//                                   context, misiklistdata.uuid) !=
//                               200) {
//                             if (mounted) {
//                               setMisiklistBookmark(context, misiklistdata.uuid);
//                             }
//                           }
//                         }
//                       }
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.bookmark,
//                           color: (context
//                                   .watch<MisiklistProvider>()
//                                   .favMisiklists
//                                   .contains(misiklistdata.uuid))
//                               ? ColorStyles.red
//                               : ColorStyles.silver,
//                         ),
//                         const Gap(3),
//                         Text(
//                           '찜',
//                           style: TextStyle(
//                               color: (context
//                                       .watch<MisiklistProvider>()
//                                       .favMisiklists
//                                       .contains(misiklistdata.uuid))
//                                   ? ColorStyles.red
//                                   : ColorStyles.black),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ))
//         : Container();
//   }
// }
