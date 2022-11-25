// ///
// ///@desc:
// ///@author: jzhang28
// ///@date: 2022年06月22 14点11分，Wednesday
// ///
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_ztrip/base/style/colors.dart';
// import 'package:flutter_ztrip/base/style/dimens.dart';
// import 'package:flutter_ztrip/base/util/log_util.dart';
// import 'package:flutter_ztrip/base/util/screen_util.dart';
// import 'package:flutter_ztrip/base/util/string_util.dart';
// import 'package:flutter_ztrip/base/util/util.dart';
// import 'package:flutter_ztrip/hotel/foundation/component/ztrip_image.dart';
// import 'package:flutter_ztrip/hotel/foundation/constant.dart';
// import 'package:flutter_ztrip/hotel/foundation/style/colors.dart';
// import 'package:flutter_ztrip/hotel/foundation/style/icon_fonts.dart';
// import 'package:flutter_ztrip/hotel/foundation/util/hotel_log_uitl.dart';
// import 'package:flutter_ztrip/hotel/module/detail/entity/hotel_discount_price_detail.dart';
// import 'package:flutter_ztrip/hotel/module/hotel_list/model/HotelMaskTagInfo.dart';
// import 'package:flutter_ztrip/hotel/module/hotel_list/view/hotel_list_log_trace_data.dart';
// import 'package:trip_common/trip_common.dart';
// import 'package:tuple/tuple.dart';
//
// import '../hotel_detail_log_trace_data.dart';
//
// /// 酒店监控底部弹框
// typedef onAddBookingCallBack = void Function();
//
// // ignore: must_be_immutable
// class HotelPriceDetailDialogWidget extends StatefulWidget {
//   ///促销优惠列表
//   List<HotelDiscountPriceDetail>? promotionDetailList;
//
//   ///点击底部预定按钮的操作回调
//   final onAddBookingCallBack callBack;
//
//   ///原价
//   num? salePrice;
//
//   ///打折价
//   num? couponSalePrice;
//
//   /// 面纱标签
//   HotelMaskTagInfo? maskTag;
//
//   /// 是否来源于列表
//   final bool isListSource;
//
//   HotelPriceDetailDialogWidget(this.promotionDetailList, this.salePrice,
//       this.couponSalePrice, this.maskTag, this.callBack,
//       {this.isListSource = false})
//       : super();
//
//   @override
//   State<StatefulWidget> createState() => _HotelPriceDetailDialogWidgetState();
// }
//
// class _HotelPriceDetailDialogWidgetState
//     extends State<HotelPriceDetailDialogWidget> {
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.setup(context);
//     return MediaQuery(
//         data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//         // 不跟随系统字体变化
//         child: getPriceDetailInfoDialog(widget.promotionDetailList));
//   }
//
//   ///============================dialog总体UI显示==============================
//   ///获取房间详情的弹出信息
//   Widget getPriceDetailInfoDialog(
//       List<HotelDiscountPriceDetail>? promotionDetailList) {
//     Widget discountPriceInfoWidget = Container();
//     if (promotionDetailList != null && promotionDetailList.length != 0) {
//       discountPriceInfoWidget = Container(
//         child: ConstrainedBox(
//           constraints:
//           BoxConstraints(maxHeight: ScreenUtil.getScreenHeight() * 0.5),
//           child: Stack(
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.fromLTRB(0, Dimens.dialog_header_height, 0,
//                     Dimens.dialog_footer_height),
//                 child:
//                 SingleChildScrollView(child: getPriceDetailDialogContent()),
//               ),
//               Positioned(
//                 child: getPriceDetailDialogHeader(),
//               ),
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 child: getPriceDetailDialogFooter(),
//               )
//             ],
//           ),
//         ),
//         clipBehavior: Clip.antiAlias,
//         decoration: BoxDecoration(
//             color: HotelColors.white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(Dimens.image_border_radius16),
//                 topRight: Radius.circular(Dimens.image_border_radius16))),
//       );
//     }
//     return discountPriceInfoWidget;
//   }
//
//   ///获取酒店价格详情widget
//   Widget getPriceDetailDialogContent() {
//     var redGradualColor = LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomLeft,
//         stops: [0.0, 1.0],
//         colors: [HotelColors.white, HotelColors.hotel_detail_bg_color]);
//
//     ///添加价格明细数据头尾
//     List<Tuple3<String, String, String>> promotionDetailListPair =
//     getHotelDiscountPriceDetail() as List<Tuple3<String, String, String>>;
//     List<Widget> promotionDetailWidgets = [];
//     if (promotionDetailListPair != null &&
//         promotionDetailListPair.length != 0) {
//       for (var i = 0; i < promotionDetailListPair.length; i++) {
//         promotionDetailWidgets.add(getHotelPriceInfoWidget(
//             i, promotionDetailListPair[i], promotionDetailListPair.length));
//         if (i == 0) {
//           ///添加价格明细的内容
//           if (widget.promotionDetailList != null &&
//               widget.promotionDetailList?.length != 0) {
//             widget.promotionDetailList!.forEach((element) {
//               promotionDetailWidgets
//                   .add(getHotelDiscountPriceInfoItemWidget(element));
//             });
//           }
//         }
//       }
//     }
//     return Container(
//       decoration: BoxDecoration(gradient: redGradualColor),
//       child: Container(
//         margin: EdgeInsets.only(
//             left: Dimens.gap_dp8,
//             right: Dimens.gap_dp8,
//             bottom: Dimens.gap_dp8),
//         padding: EdgeInsets.only(
//             left: Dimens.gap_dp12,
//             right: Dimens.gap_dp12,
//             bottom: Dimens.gap_dp30),
//         decoration: BoxDecoration(
//             color: HotelColors.white,
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(Dimens.gap_dp8),
//                 bottomRight: Radius.circular(Dimens.gap_dp8))),
//         child: Column(children: promotionDetailWidgets),
//       ),
//     );
//   }
//
//   ///获取灰色分割线组件
//   Widget getGrayDottedLine() {
//     return Container(
//         margin: EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
//         child: Image.asset(
//           'assets/hotel/images/gray_dotted_line.png',
//           width: double.infinity,
//           height: 1,
//           fit: BoxFit.cover,
//         ));
//   }
//
//   ///获取房间价格名字的每一个item
//   Widget getHotelDiscountPriceInfoItemWidget(
//       HotelDiscountPriceDetail discountPriceDetail) {
//     return Container(
//       margin: EdgeInsets.only(top: Dimens.gap_dp17),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               discountPriceDetail.icon != null &&
//                   StringUtil.isNotEmpty(discountPriceDetail.icon)
//                   ? ConstrainedBox(
//                 constraints:
//                 BoxConstraints(maxWidth: Dimens.image_width100),
//                 child: ZTripImage(
//                   discountPriceDetail.icon ?? "",
//                   height: Dimens.image_height16,
//                   width: double.infinity,
//                   fit: BoxFit.fitHeight,
//                   alignment: Alignment.topLeft,
//                 ),
//               )
//                   : Container(
//                 padding: EdgeInsets.symmetric(
//                     vertical: Dimens.gap_dp1, horizontal: Dimens.gap_dp4),
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         color: HotelColors.platform_red_and_orange
//                             .withOpacity(0.4),
//                         width: Dimens.gap_dp_half),
//                     borderRadius:
//                     BorderRadius.all(Radius.circular(Dimens.gap_dp4)),
//                     color: HotelColors.platform_red_and_orange
//                         .withOpacity(0.08)),
//                 child: Text(
//                   discountPriceDetail.title ?? "",
//                   style: TextStyle(
//                       fontSize: Dimens.font_sp12,
//                       fontWeight: FontWeight.w500,
//                       color: HotelColors.platform_red_and_orange),
//                 ),
//               ),
//               Expanded(child: getGrayDottedLine()),
//               Text(
//                 "-¥${discountPriceDetail.price ?? ""}",
//                 style:
//                 TextStyle(color: getMemberRightColor(discountPriceDetail)),
//               ),
//             ],
//           ),
//           Visibility(
//               visible: StringUtil.isNotEmpty(discountPriceDetail.desc) ||
//                   StringUtil.isNotEmpty(discountPriceDetail.remark),
//               child: Container(
//                 child: Text(
//                   (discountPriceDetail.desc != null &&
//                       StringUtil.isNotEmpty(discountPriceDetail.desc))
//                       ? discountPriceDetail.desc ?? ""
//                       : discountPriceDetail.remark ?? "",
//                   style: TextStyle(
//                       fontSize: Dimens.font_sp11, color: HotelColors.gray9),
//                 ),
//                 margin: EdgeInsets.only(top: Dimens.gap_dp4),
//               ))
//         ],
//       ),
//     );
//   }
//
//   ///获取会员权益颜色
//   Color getMemberRightColor(HotelDiscountPriceDetail discountPriceDetail) {
//     Color memberColor = HotelColors.platform_red_and_orange;
//     if (discountPriceDetail.memberLevel != null &&
//         discountPriceDetail.memberLevel != 0) {
//       var level = discountPriceDetail.memberLevel;
//       if (level == HotelConstant.COMMON_MEMBER) {
//         memberColor = HotelColors.platform_red_and_orange;
//       } else if (level == HotelConstant.SLIVER_MEMBER) {
//         memberColor = HotelColors.platform_red_and_orange;
//       } else if (level == HotelConstant.GOLD_MEMBER) {
//         memberColor = HotelColors.gold_member_color;
//       } else if (level == HotelConstant.PLATINUM_MEMBER) {
//         memberColor = HotelColors.platinum_member_color;
//       } else if (level == HotelConstant.BLACK_DIAMOND) {
//         memberColor = HotelColors.black_diamond_member_color;
//       } else {
//         memberColor = HotelColors.platform_red_and_orange;
//       }
//     }
//     return memberColor;
//   }
//
//   ///获取房间价格明细的原价和促销价widget
//   Widget getHotelPriceInfoWidget(
//       int index, Tuple3<String, String, String> data, int total) {
//     /// 面纱标签和详细描述
//     String? maskTagStr = widget.maskTag?.maskTag ?? '';
//     String? maskTagDesc = widget.maskTag?.maskTagDesc ?? '';
//     return Container(
//         margin: EdgeInsets.only(top: Dimens.gap_dp12),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 data.item1,
//                 style: TextStyle(
//                     fontSize: Dimens.font_sp14,
//                     fontWeight: FontWeight.w600,
//                     color: HotelColors.gray3),
//               ),
//               Visibility(
//                   child: Container(
//                       child: ZTripImage(
//                         maskTagStr,
//                         width: Dimens.gap_dp61,
//                         height: Dimens.gap_dp16,
//                       ),
//                       margin: EdgeInsets.only(left: Dimens.gap_dp8)),
//                   visible: (data.item1 == '房费原价' &&
//                       StringUtil.isNotEmpty(maskTagStr))),
//               Expanded(
//                 child:
//                 Visibility(child: getGrayDottedLine(), visible: index == 0),
//               ),
//               Container(
//                   child: Row(
//                     children: [
//                       Visibility(
//                         child: Container(
//                           margin: EdgeInsets.only(
//                               right: Dimens.gap_dp2, top: Dimens.gap_dp8),
//                           child: Text(
//                             "每间每晚",
//                             style: TextStyle(
//                                 fontSize: Dimens.font_sp13,
//                                 color: HotelColors.gray3),
//                           ),
//                         ),
//                         visible: index == 1,
//                       ),
//                       Visibility(
//                         visible: index == 1,
//                         child: Container(
//                           child: Text(
//                             "¥",
//                             style: TextStyle(
//                                 color: HotelColors.platform_red_and_orange),
//                           ),
//                           margin: EdgeInsets.only(top: Dimens.gap_dp8),
//                         ),
//                       ),
//                       Text(
//                         data.item3,
//                         style: TextStyle(
//                             fontSize:
//                             index == 1 ? Dimens.font_sp24 : Dimens.font_sp14,
//                             color: index == 0
//                                 ? HotelColors.gray6
//                                 : HotelColors.platform_red_and_orange,
//                             decoration: index == 0
//                                 ? TextDecoration.lineThrough
//                                 : TextDecoration.none,
//                             fontFamily: 'HotelNumberFont'),
//                       )
//                     ],
//                   ))
//             ],
//           ),
//           Visibility(
//               visible:
//               (data.item1 == '房费原价' && StringUtil.isNotEmpty(maskTagDesc)),
//               child: Container(
//                 child: Text(
//                   maskTagDesc,
//                   style: TextStyle(
//                       fontSize: Dimens.font_sp11, color: HotelColors.gray9),
//                 ),
//                 margin: EdgeInsets.only(top: Dimens.gap_dp4),
//               ))
//         ]));
//   }
//
//   ///获取房间价格展示的明细数据
//   List<Tuple3> getHotelDiscountPriceDetail() {
//     //组装展示的数据
//     List<Tuple3<String, String, String>> promotionDetailListPair = [];
//
//     if (widget.salePrice != null &&
//         StringUtil.isNotEmpty("${widget.salePrice}")) {
//       promotionDetailListPair.add(Tuple3("房费原价", "", "¥${widget.salePrice}"));
//     }
//     if (widget.couponSalePrice != null &&
//         StringUtil.isNotEmpty("${widget.couponSalePrice}")) {
//       promotionDetailListPair.add(Tuple3("", "", "${widget.couponSalePrice}"));
//     }
//     return promotionDetailListPair;
//   }
//
//   ///============================dialog底部UI显示==============================
//   ///获取房间详情的弹出信息尾部widget
//   Widget getPriceDetailDialogFooter() {
//     return Container(
//         color: ZTColors.white,
//         width: ScreenUtil.getScreenWidth(),
//         height: Dimens.dialog_footer_height,
//         margin: EdgeInsets.only(bottom: ScreenUtil.isIPhoneX ? 14 : 4),
//         child: Column(
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 HotelLogUtil.logListClickTrace(
//                     HotelListTraceData.hotel_list_coupon_tag_pop_click,
//                     info: {"clickType": "ord"});
//                 Navigator.pop(context);
//                 LogUtil.logBizTrace(
//                     HotelDetailTraceData.HOTEL_DETAIL_CLICK,
//                     HotelDetailTraceData.HOTEL_DETAIL_PRICE_DETAIL_POP_CLICK,
//                     {'clickType': 'ord'});
//                 Future.delayed(Duration(milliseconds: 400), () {
//                   widget.callBack();
//                 });
//               },
//               child: Container(
//                 height: Dimens.dialog_footer_height - 2,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       vertical: Dimens.gap_dp10, horizontal: Dimens.gap_dp15),
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "立即预订",
//                       key: Key("id_hotel_price_detail_book"),
//                       style: TextStyle(
//                           fontSize: Dimens.font_sp18, color: HotelColors.white),
//                     ),
//                     decoration: BoxDecoration(
//                         color: HotelColors.platform_red_and_orange,
//                         borderRadius: BorderRadius.all(
//                             Radius.circular(Dimens.image_border_radius22))),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   ///============================dialog导航栏显示==============================
//   ///获取房间详情的弹出信息头部导航栏
//   Widget getPriceDetailDialogHeader() {
//     return Container(
//       padding: EdgeInsets.all(Dimens.gap_dp16),
//       child: Stack(
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                   child: Text(
//                     "每间每晚价格说明",
//                     style: TextStyle(
//                         fontSize: Dimens.font_sp18,
//                         fontWeight: FontWeight.w600,
//                         color: HotelColors.gray2),
//                   ))
//             ],
//           ),
//           Positioned(
//             child: GestureDetector(
//                 onTap: () {
//                   if (widget.isListSource) {
//                     HotelLogUtil.logListClickTrace(
//                         HotelListTraceData.hotel_list_coupon_tag_pop_click,
//                         info: {"clickType": "close"});
//                   } else {
//                     LogUtil.logBizTrace(
//                         HotelDetailTraceData.HOTEL_DETAIL_CLICK,
//                         HotelDetailTraceData
//                             .HOTEL_DETAIL_PRICE_DETAIL_POP_CLICK,
//                         {'clickType': 'close'});
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Icon(
//                   HotelIcons.cancel_icon,
//                   size: Dimens.font_sp24,
//                   color: HotelColors.gray9,
//                 )),
//             right: 0,
//           ),
//         ],
//       ),
//     );
//   }
// }
