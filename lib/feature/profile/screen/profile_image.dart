// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:foodify/core/model/image_data.dart';
// import 'package:foodify/core/widget/image/blur_image_widget.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import '../../../../core/helper/app_image_helper.dart';
// import '../../../../core/helper/language_helper.dart';
// import '../../../../core/resource/color_manager.dart';
// import '../../../../core/resource/image_manager.dart';
// import '../../../../core/resource/size_manager.dart';
// import '../../../../core/storage/shared/shared_pref.dart';
//
// class ProfileImage extends StatefulWidget {
//   final void Function(File) onAddClicked;
//   final ImageData? image;
//
//   const ProfileImage({required this.onAddClicked, this.image});
//
//   @override
//   State<ProfileImage> createState() => _ProfileImageState();
// }
//
// class _ProfileImageState extends State<ProfileImage> {
//   File? profileImage;
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: Stack(
//         children: [
//           Visibility(
//             visible: profileImage?.path == null,
//             replacement: Container(
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               alignment: Alignment.center,
//               height: AppHeightManager.h13,
//               width: AppHeightManager.h13,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                       color: AppColorManager.lightGreyOpacity6,
//                       offset: Offset(
//                         -2,
//                         2,
//                       ),
//                       blurRadius: 4,
//                       spreadRadius: 4)
//                 ],
//                 color: AppColorManager.shimmerBaseColor,
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: FileImage(
//                     profileImage ?? File(""),
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             child: widget.image?.image?.isNotEmpty ?? false
//                 ? Container(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//
//                     // alignment: Alignment.center,
//                     height: AppHeightManager.h13,
//                     width: AppHeightManager.h13,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         LanguageHelper.checkIfLTR(context: context)
//                             ? BoxShadow(
//                                 color: AppColorManager.blackShadow1,
//                                 offset: Offset(4, -2),
//                                 blurRadius: 7,
//                                 spreadRadius: 1,
//                               )
//                             : BoxShadow(
//                                 color: AppColorManager.blackShadow1,
//                                 offset: Offset(-4, -2),
//                                 blurRadius: 7,
//                                 spreadRadius: 1,
//                               )
//                       ],
//                       shape: BoxShape.circle,
//                     ),
//                     child: BlurImageWidget(
//                         imageUrl: widget.image?.image ?? "",
//                         imageAsBase64: widget.image?.loaderData ?? ""),
//                   )
//                 : Container(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     alignment: Alignment.center,
//                     height: AppHeightManager.h13,
//                     width: AppHeightManager.h13,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                             color: AppColorManager.lightGreyOpacity6,
//                             offset: Offset(
//                               -2,
//                               2,
//                             ),
//                             blurRadius: 4,
//                             spreadRadius: 4)
//                       ],
//                       color: AppColorManager.shimmerBaseColor,
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: AssetImage(
//                           AppImageManager.placeholder,
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//           ),
//           Positioned(
//             bottom: AppHeightManager.h1point5,
//             left: AppWidthManager.w18,
//             right: 0,
//             child: InkWell(
//               onTap: () async {
//                 profileImage = await AppImageHelper.pickImageFrom(
//                     source: ImageSource.gallery);
//                 widget.onAddClicked(profileImage ?? File(""));
//                 setState(() {});
//               },
//               child: Container(
//                 padding: EdgeInsets.all(AppWidthManager.w1),
//                 decoration: const BoxDecoration(
//                     color: AppColorManager.textAppColor,
//                     shape: BoxShape.circle),
//                 child: Icon(
//                   Icons.edit,
//                   color: AppColorManager.white,
//                   size: 17.px,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
