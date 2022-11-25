import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../../base/component/LinesWrap.dart';
import '../../../base/material/Dimens.dart';
import '../../../base/material/HotelColors.dart';
import '../../../base/material/icon_fonts.dart';
import '../../../base/utils/color_util.dart';
import '../../../base/utils/string_util.dart';
import '../../../base/utils/util.dart';
import '../image/HotelListImage.dart';
import '../model/HotelListModel.dart';

// ignore: constant_identifier_names
const AssetHotelImagePath = "assets/images/list/";

typedef OnOpenDetailPageCallBack = void Function();

// ignore: must_be_immutable
class HotelListItemWidget extends StatelessWidget {
  final HotelList? hotel;
  OnOpenDetailPageCallBack? callBack;
  int? index;

  final double logoWidth = 105;
  var remarkContainerHidden = true;
  bool? isOverseas = false;
  bool? needSeperatorLine = true; // 是否需要分割线

  /// 是否为新客，新客的AB去掉可以把这块逻辑全部干掉
  final bool isNewCustom;

  // ignore: prefer_typing_uninitialized_variables
  final isMapTopHotel;

  HotelListItemWidget(this.isNewCustom,
      {Key? key,
      this.hotel,
      this.isOverseas,
      this.index,
      this.callBack,
      this.isMapTopHotel = false,
      this.needSeperatorLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bgColor = Colors.white;
    final content = Column(
      children: [_bgContent(bgColor, context), separator(context)],
    );
    return Stack(
      children: [
        isMapTopHotel
            ? Container(
                decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(
                        width: 2, color: HotelColors.hotel_list_map_color)),
                child: content,
              )
            : Container(color: bgColor, child: content),
        Positioned(
            right: 0,
            top: 0,
            child: Visibility(
                visible: isMapTopHotel,
                child: Image.asset(
                  HotelListImage.mapTopTag,
                  width: 14,
                  height: 14,
                )))
      ],
    );
  }

  Widget _bgContent(Color bgColor, BuildContext context) {
    return Container(
        color: bgColor,
        padding: const EdgeInsets.only(
            left: Dimens.gap_dp10, top: Dimens.gap_dp7, bottom: Dimens.gap_dp7),
        child: _roomInfoContent(context));
  }

  Widget _roomInfoContent(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          hotelListItemLogoContent(context),
          hotelListDesContent(context),
        ]));
  }

  // Logo Content
  Widget hotelListItemLogoContent(BuildContext context) {
    return Stack(
      children: [
        hotelListItemLogo(context),
        // Positioned(left: 0, top: 0, child: topLogoRemark()),
        Positioned(
          left: 0,
          top: 0,
          child: topLogoShowRemark(),
        ),
        Positioned(
          right: Dimens.gap_dp4,
          top: Dimens.gap_dp4,
          child: collectItem(),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                width: logoWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [advertiseFlagView()],
                ),
              ),
              remarkContainer()
            ],
          ),
        )
      ],
    );
  }

  Widget hotelListItemLogo(BuildContext context) {
    var logo = (StringUtil.isNullOrEmpty(hotel!.logo) ? "" : hotel!.logo);
    return Container(
      width: logoWidth,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.image_border_radius6)),
          image: DecorationImage(
              image: NetworkImage(logo ?? ''), fit: BoxFit.cover)),
    );
  }

  Widget topLogoShowRemark() {
    var topLogoShowImg = hotel!.hotelExtraInfo!.logoShowInfo!.topLogoShowImg ?? "";
    return Visibility(
      visible: !StringUtil.isNullOrEmpty(topLogoShowImg),
      child: Image.network(
        topLogoShowImg,
        height: Dimens.gap_dp16,
      ),
    );
  }

  Widget hotelListeItemNetworkRemark(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
      child: Image.network(
        hotel!.hotelExtraInfo!.logoShowInfo!.logoShowIcon!,
        height: 18,
      ),
    );
  }

  // 收藏
  Widget collectItem() {
    var visible = hotel!.hotelExtraInfo!.logoShowInfo!.logoShowType == 512;
    return Visibility(
      visible: visible,
      child: Image.asset(
        "assets/images/hotel_list_yisc@3x.webp",
        height: Dimens.gap_dp14,
        width: Dimens.gap_dp14,
      ),
    );
  }

  // RemarkContainer
  Widget remarkContainer() {
    var logoRemark = hotel!.hotelExtraInfo!.logoShowInfo!.logoRemark ?? "";
    var logoShowType = hotel!.hotelExtraInfo!.logoShowInfo!.logoShowType ?? 0;
    var logoShowIcon = hotel!.hotelExtraInfo!.logoShowInfo!.logoShowIcon ?? "";

    Color leftColor;
    Color rightColor;
    var remarkColor = Colors.white;
    var remarkIconColor = Colors.white;
    String remarkImg = "";

    if (logoRemark.isNotEmpty) {
      if ((logoShowType & 1) == 1) {
        leftColor = HotelColors.hotel_list_remark_color1;
        rightColor = HotelColors.hotel_list_remark_color1;
      } else if ((logoShowType & 2) == 2) {
        leftColor = HotelColors.hotel_list_remark_color2;
        rightColor = HotelColors.hotel_list_remark_color2;
      } else if ((logoShowType & 8) == 8) {
        leftColor = HotelColors.hotel_list_remark_color8;
        rightColor = HotelColors.hotel_list_remark_color8_r;
      } else if ((logoShowType & 16) == 16) {
        leftColor = HotelColors.hotel_list_remark_color16;
        rightColor = HotelColors.hotel_list_remark_color16;
      } else if ((logoShowType & 32) == 32) {
        leftColor = HotelColors.hotel_list_remark_color32;
        rightColor = HotelColors.hotel_list_remark_color32;
      } else if ((logoShowType & 64) == 64) {
        leftColor = HotelColors.hotel_list_remark_color64;
        rightColor = HotelColors.hotel_list_remark_color64_r;
      } else if ((logoShowType & 256) == 256) {
        leftColor = HotelColors.hotel_list_remark_color256;
        rightColor = HotelColors.hotel_list_remark_color256;
      } else if ((logoShowType & 1024) == 1024) {
        remarkImg = logoShowIcon;
      } else if ((logoShowType & 2048) == 2048) {
        remarkImg = logoShowIcon;
      } else if ((logoShowType & 4096) == 4096) {
        remarkImg = logoShowIcon;
        remarkIconColor = HotelColors.hotel_list_remark_color4096;
        remarkColor = HotelColors.hotel_list_remark_color4096;
      } else if ((logoShowType & 8192) == 8192) {
        remarkImg = logoShowIcon;
      } else if ((logoShowType & 16384) == 16384) {
        remarkImg = logoShowIcon;
        remarkColor = Colors.white;
      } else if ((logoShowType & 32768) == 32768) {
        remarkImg = logoShowIcon;
        remarkColor = Colors.white;
      } else {
        leftColor = HotelColors.hotel_list_remark_color;
        rightColor = HotelColors.hotel_list_remark_color;
      }
    }

    var visibleRemarkImg = StringUtil.isNotEmpty(remarkImg);
    remarkContainerHidden = (logoRemark.isNotEmpty && remarkImg.isNotEmpty);
    EdgeInsets insets = hotel!.hotelExtraInfo!.logoShowInfo!.priority == 1
        ? const EdgeInsets.only(left: 9, bottom: 1, top: 0)
        : const EdgeInsets.only(top: 2);

    return Visibility(
        visible: logoRemark.isNotEmpty && remarkImg.isNotEmpty,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 21,
          width: logoWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 21,
                width: logoWidth,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4))),
                child: Image.network(
                  remarkImg,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: insets,
                child: Text(
                  logoRemark,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: remarkIconColor,
                      fontSize: Dimens.font_sp11,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ));
  }

  // ===========================================  左侧酒店的描述信息  ================================
  Widget hotelListDesContent(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.font_sp10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  hotelListDesName(),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: hotelListRemarkContent(),
                  ),
                  commentView(),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: hotelListAddressContent(),
                  ),
                  promotionTagList(),
                  rankInfoView(),
                  priceAndOrderContent(context),
                  pricePK(),
                ],
              ),
            ),
            Positioned(
                right: Dimens.gap_dp10,
                top: Dimens.gap_dp10,
                bottom: Dimens.gap_dp10,
                child: fullRoomItem()),
          ],
        ));
  }

  // 榜单
  Widget rankInfoView() {
    const rankBgColor = Color(0xFFFFF4DE);
    const rankTextColor = Color(0xFF803906);
    final rankInfo = hotel!.hotelRankInfo;
    if (rankInfo != null) {
      return Container(
        margin: const EdgeInsets.only(top: 6),
        height: 14,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: rankBgColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2),
                      bottomLeft: Radius.circular(2))),
              child: Image.network(
                rankInfo.icon ?? "",
                height: 14,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: const BoxDecoration(
                  color: rankBgColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(2),
                      bottomRight: Radius.circular(2))),
              child: Text(rankInfo.desc ?? '',
                  style: const TextStyle(
                    color: rankTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  )),
            )
          ],
        ),
      );
    }
    return Container();
  }

  // 酒店名称 类型
  Widget hotelListDesName() {
    List<InlineSpan> widgets = [];
    widgets.add(
      TextSpan(
        text: hotel!.name,
        style: TextStyle(
          color: fullRoomColor() ?? HotelColors.gray3,
          fontSize: Dimens.font_sp16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    widgets.add(WidgetSpan(child: _hotelListBrand()));
    final tuple = _getHotelLevelWidget();
    if (tuple.item2) {
      widgets.add(WidgetSpan(child: tuple.item1));
    }
    // 空铁挂牌扶持
    final supportIcon = hotel!.starIcon;
    if (supportIcon != null && StringUtil.isNotEmpty(supportIcon)) {
      widgets.add(WidgetSpan(
          child: Image.network(
        supportIcon??"",
        width: 18,
        height: 18,
      )));
    }

    return Container(
        margin: EdgeInsets.only(right: advertiseFlag() ? 20 : 0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(children: widgets),
                key: Key("id_hotel_list_item_name#$index"),
                maxLines: 4,
              ),
            ),
          ],
        ));
  }

  advertiseFlag() {
    return hotel!.hotelExtraInfo!.advertiseFlag ?? false;
  }

  Widget advertiseFlagView() {
    if (advertiseFlag()) {
      return Container(
        alignment: Alignment.center,
        width: 20,
        height: 12,
        child: Text(
          "广告",
          style: TextStyle(
              color: HotelColors.gray8,
              fontSize: 8,
              fontWeight: FontWeight.w400,
              shadows: [
                Shadow(
                    color: HotelColors.black.withOpacity(0.2),
                    offset: const Offset(0, 0),
                    blurRadius: 1)
              ]),
        ),
      );
    }
    return Container();
  }

  // 酒店商标
  Widget _hotelListBrand() {
    final hotelBrand = hotel!.hotelAddInfo!.hotelBrandLabel ?? '';
    return Visibility(
        visible: StringUtil.isNotEmpty(hotelBrand),
        child: Container(
          padding: const EdgeInsets.only(left: 5, bottom: 2),
          child: DecoratedBox(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                image: DecorationImage(
                  image: AssetImage(
                      "${AssetHotelImagePath}hotel_hotelList_brand_bg@3x.webp"),
                  fit: BoxFit.cover,
                )),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(hotelBrand,
                  style: const TextStyle(
                      color: HotelColors.hotel_list_brand_color,
                      fontSize: 9,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ));
  }

  ///根据酒店的星级获取表widget
  Tuple2<Widget, bool> _getHotelLevelWidget() {
    List<Widget> hotelStarWidgetList = [];
    var star = 0;
    try {
      if (StringUtil.isNotEmpty(hotel!.star)) {
        star = int.parse(hotel!.star ?? 0 as String);
      }
    } catch (e) {}

    if (isOverseas!) {
      if (null != hotel!.star && star > 0) {
        for (var i = 0; i < star; i++) {
          hotelStarWidgetList.add(
            Container(
              height: 21,
              padding: const EdgeInsets.fromLTRB(
                  Dimens.gap_dp_half, Dimens.gap_dp6, Dimens.gap_dp_half, 0),
              child: Image.asset(
                  '${AssetHotelImagePath}hotel_list_hotel_star@3x.webp',
                  width: Dimens.image_width10,
                  height: Dimens.image_height13),
            ),
          );
        }
        return Tuple2(
            Container(
              width: Dimens.image_width12 * star,
              margin: const EdgeInsets.only(
                  left: Dimens.gap_dp4, right: Dimens.gap_dp2),
              child: Row(children: hotelStarWidgetList),
            ),
            true);
      }
    } else {
      // ignore: null_aware_before_operator
      if (null != hotel!.hotelStar && hotel!.hotelStar != 0) {
        for (var i = 0; i < hotel!.hotelStar!.toInt(); i++) {
          hotelStarWidgetList.add(
            Container(
              height: 21,
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.gap_dp_half),
              child: Image.asset(
                  '${AssetHotelImagePath}hotel_list_hotel_star@3x.webp',
                  width: Dimens.image_width10,
                  height: Dimens.image_height13),
            ),
          );
        }
        return Tuple2(
            Container(
              width: Dimens.image_width12 * hotel!.hotelStar!,
              margin: const EdgeInsets.only(
                  left: Dimens.gap_dp4, right: Dimens.gap_dp2),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: hotelStarWidgetList),
            ),
            true);
      }
    }
    return Tuple2(Container(), false);
  }

  // // 是否为海外酒店
  // bool isOverseas() {
  //   return ((hotel.bizType  0) = 1);
  // }

  // 评分、评论
  Widget hotelListRemarkContent() {
    final remarkInfo = hotel!.hotelAddInfo!;

    final commonScoreText = remarkInfo.commonScore ?? "";
    final commonScoreNum = double.tryParse(commonScoreText) ?? 0.0;
    final isCommonScore = commonScoreNum > 0.0;

    var commentNumberText = "";
    const commentNumberColor = HotelColors.gray3;
    commentNumberText = remarkInfo.commentNumber ?? "";

    if (hotel!.collectionNumber != null) {
      commentNumberText += ' · ${hotel!.collectionNumber}';
    }
    final commentNumTextStyle = TextStyle(
        color: fullRoomColor() ?? commentNumberColor,
        fontSize: Dimens.font_sp12,
        fontWeight: FontWeight.normal,
        height: 1);
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
              visible: isCommonScore,
              child: Container(
                height: 15,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3),
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(8)),
                    color: Color(0xFF1480EC)),
                child: Text(
                  commonScoreText,
                  style: TextStyle(
                      color: fullRoomColor() ?? HotelColors.white,
                      fontSize: Dimens.font_sp13,
                      height: 1,
                      fontFamily: 'NumberIconFont'),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              commentNumberText,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              key: Key("id_hotel_list_item_comment#$index"),
              style: commentNumTextStyle,
            ),
          )
        ]);
  }

  // 评论、推荐词
  commentView() {
    // 优先展示推荐词
    var text = hotel!.recommendWord ?? hotel!.commentView ?? '';
    if (text.isEmpty) return Container();
    if (text.isNotEmpty) {
      text = '"$text"';
    }
    return Container(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: fullRoomColor() ?? const Color(0xFF386CA3),
            fontSize: Dimens.font_sp12,
            fontWeight: FontWeight.w500,
            height: 1),
      ),
    );
  }

  // 位置
  Widget hotelListAddressContent() {
    var extraInfo = hotel!.hotelAddInfo!;
    var location = hotel!.zone!;
    if (Util.isEmptyString(location)) {
      location = hotel!.location ?? '';
    }
    final textColor = fullRoomColor() ??
        (isMapTopHotel
            ? HotelColors.hotel_list_address_color
            : HotelColors.gray6);

    final List<InlineSpan> textWidgets = [];
    textWidgets.add(TextSpan(
        text: extraInfo.distanceRemark ?? '',
        style: TextStyle(
            color: textColor,
            fontSize: Dimens.font_sp12,
            fontWeight: FontWeight.normal)));

    textWidgets.add(
      WidgetSpan(
          child: Visibility(
              visible: Util.isNotEmptyString(location) &&
                  Util.isNotEmptyString(extraInfo.distanceRemark),
              child: Text(' · ',
                  style: TextStyle(
                      color: textColor,
                      fontSize: Dimens.font_sp12,
                      fontWeight: FontWeight.normal)))),
    );
    textWidgets.add(TextSpan(
        text: location ?? '',
        style: TextStyle(
            color: textColor,
            fontSize: Dimens.font_sp12,
            fontWeight: FontWeight.normal)));
    return Text.rich(
      TextSpan(children: textWidgets),
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }

  // 标签列表
  Widget promotionTagList() {
    var tags = (hotel!.hotelAddInfo!.promotionTagList ?? []).toList();
    var tagWidgets = tags.map((e) => promotionTagItem(e)).toList();
    return Visibility(
      visible: Util.isEmptyList(tags),
      child: Container(
        height: Dimens.gap_dp20,
        padding: EdgeInsets.zero,
        alignment: Alignment.centerLeft,
        child: LinesWrap(
          spacing: Dimens.gap_dp2,
          lines: 1,
          children: tagWidgets,
        ),
      ),
    );
  }

  Widget promotionTagItem(PromotionTagList tagItem) {
    var bgColor = ColorUtil.string2Color(tagItem.backgroundColor ?? '');
    var borderColor = ColorUtil.string2Color(tagItem.borderColor ?? '');
    var textColor = ColorUtil.string2Color(tagItem.textColor ?? '');
    var tagText = (tagItem.text ?? '') + (tagItem.tagAmount ?? '');
    var iconUrl = tagItem.iconUrl ?? '';
    var paddingLeft = Dimens.gap_dp3;
    var iconWidth = Dimens.gap_dp12;
    var iconHeight = Dimens.gap_dp13;
    return Container(
      padding:
          const EdgeInsets.only(right: Dimens.gap_dp2, top: Dimens.gap_dp4),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.gap_dp2),
          color: bgColor,
          border: Border.all(
              color: fullRoomColor() ?? borderColor, width: Dimens.gap_dp_half),
        ),
        child: Container(
            padding: EdgeInsets.only(left: paddingLeft, right: Dimens.gap_dp3),
            height: 15,
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                      visible: (StringUtil.isNotEmpty(iconUrl)),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 0.5, top: 0.5, bottom: 0.5),
                        margin: const EdgeInsets.only(right: 3),
                        child: Image.network(
                          iconUrl,
                          width: iconWidth,
                          height: iconHeight,
                          fit: BoxFit.contain,
                        ),
                      )),
                  Text(
                    tagText,
                    style: TextStyle(
                        color: fullRoomColor() ?? textColor,
                        fontSize: Dimens.gap_dp10,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            )),
      ),
    );
  }

  // 价格 订单
  Widget priceAndOrderContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: Dimens.gap_dp2),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     bookingText(),
          //     Container(
          //       padding: const EdgeInsets.only(left: 2),
          //       child: hotelListPriceContent(),
          //     )
          //   ],
          // ),
          // Container(
          //   padding: const EdgeInsets.only(bottom: 0),
          //   child: Flex(
          //     direction: Axis.horizontal,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       Expanded(
          //         flex: 1,
          //         child: _reductionSaleView(),
          //       ),
          //       promotionDiscountView(context)
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  // 可还价价格
  dickerPriceView(PriceExtraDatas data, String originPrice) {
    const priceUnit = '起';
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 3, right: 2),
            child: Image.network(
              data.icon ?? '',
              width: 35,
              height: 13,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            alignment: Alignment.bottomCenter,
            child: Text(
              '¥',
              style: TextStyle(
                  color: fullRoomColor() ?? HotelColors.hotel_list_price_color,
                  fontSize: Dimens.font_sp13,
                  fontFamily: 'NumberIconFont',
                  height: 1),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              originPrice,
              key: Key("id_hotel_list_item_price#$index"),
              style: TextStyle(
                  color: fullRoomColor() ?? HotelColors.hotel_list_price_color,
                  fontSize: 21,
                  fontFamily: 'NumberIconFont',
                  height: 1),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 1, bottom: 1),
            child: Text(
              priceUnit,
              style: TextStyle(
                  color: fullRoomColor() ?? HotelColors.gray9,
                  fontSize: Dimens.font_sp12,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  dickerPriceViewB(PriceExtraDatas data, String originPrice) {
    const priceUnit = '起';
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 14,
            margin: const EdgeInsets.only(bottom: 2, right: 4),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(3),
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(3)),
                color: HotelColors.hotel_list_price_color.withOpacity(0.18)),
            child: Row(
              children: [
                Image.asset('${AssetHotelImagePath}dicker.png'),
                Container(
                    margin: const EdgeInsets.only(left: 2, right: 4),
                    child: Text("¥$originPrice",
                        style: const TextStyle(
                            color: HotelColors.hotel_list_price_color,
                            fontFamily: 'NumberIconFont',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            height: 1)))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            alignment: Alignment.bottomCenter,
            child: Text(
              '¥',
              style: TextStyle(
                  color: fullRoomColor() ?? HotelColors.hotel_list_price_color,
                  fontSize: Dimens.font_sp13,
                  fontFamily: 'NumberIconFont',
                  height: 1),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              data.price.toString(),
              key: Key("id_hotel_list_item_price#$index"),
              style: TextStyle(
                  color: fullRoomColor() ?? HotelColors.hotel_list_price_color,
                  fontSize: 21,
                  fontFamily: 'NumberIconFont',
                  height: 1),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 1, bottom: 1),
            child: Text(
              priceUnit,
              style: TextStyle(
                  color: fullRoomColor() ?? HotelColors.gray9,
                  fontSize: Dimens.font_sp12,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget hotelListPriceContent() {
    var priceInfo = hotel!.priceInfo!;
    var discountPrice = '¥${priceInfo.discountPrice.toString() ?? '0'}';
    var originPrice = '';
    if (Util.isEmptyString(priceInfo.couponTag!)) {
      originPrice = priceInfo.salePrice.toString() ?? '';
    } else {
      originPrice = priceInfo.couponSalePrice.toString() ?? '';
    }
    var priceUnit = '起';
    final notStudentPrices = priceInfo.priceExtraDatas!;
    String? notStudentPrice;
    String? youthIcon;
    String? fontColor;
    if (Util.isEmptyList(notStudentPrices)) {
      notStudentPrice = notStudentPrices.first.price.toString();
      youthIcon = notStudentPrices.first.icon;
      fontColor = notStudentPrices.first.fontColor;
    }
    if (!Util.isEmptyList(priceInfo.priceExtraDatas!)) {
      final data = priceInfo.priceExtraDatas!.first;
      if (data.type == 5) {
        return dickerPriceView(data, originPrice);
      } else if (data.type == 6) {
        return dickerPriceViewB(data, originPrice);
      }
    } else if (!Util.isEmptyString(notStudentPrice!) && isNewCustom) {
      return _studentPriceView(
          notStudentPrice, originPrice, priceUnit, youthIcon, fontColor);
    }
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Visibility(
              visible: discountPrice != '¥0',
              child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(right: 1, bottom: 2),
                  child: Text(
                    discountPrice,
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: HotelColors.gray9,
                        fontSize: Dimens.font_sp12,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 1),
              child: Text(
                '¥',
                style: TextStyle(
                    color:
                        fullRoomColor() ?? HotelColors.hotel_list_price_color,
                    fontSize: Dimens.font_sp13,
                    fontFamily: 'NumberIconFont'),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                originPrice,
                key: Key("id_hotel_list_item_price#$index"),
                style: TextStyle(
                    color:
                        fullRoomColor() ?? HotelColors.hotel_list_price_color,
                    fontSize: 21,
                    fontFamily: 'NumberIconFont'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 1, bottom: 1),
              child: Text(
                priceUnit,
                style: TextStyle(
                    color: fullRoomColor() ?? HotelColors.gray9,
                    fontSize: Dimens.font_sp12,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool isStudentPriceShow() {
    final notStudentPrices = hotel!.priceInfo!.priceExtraDatas!
        .where((element) => element.type == 1)
        .toList();
    return Util.isEmptyList(notStudentPrices);
  }

  // 价格PK
  Widget pricePK() {
    final prices = hotel!.hotelExtraInfo!.platformPriceList ?? [];
    if (prices.isEmpty) return Container();
    final widgets = prices
        .expand((price) => [pricePKItem(price), priceSeparatorPK()])
        .toList();
    widgets.removeLast();
    return Container(
      height: 19,
      margin: const EdgeInsets.only(top: 5),
      decoration: const BoxDecoration(
          color: Color(0xFFF9FAFB),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        children: widgets,
      ),
    );
  }

  Widget pricePKItem(PlatformPriceList price) {
    var priceText =
        '${price.platformName ?? ''} ¥${price.platformPriceDisplay ?? '--'}';
    return Expanded(
        flex: 10,
        child: Text(priceText,
            textAlign: TextAlign.center,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: HotelColors.gray9,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                height: 1.1)));
  }

  Widget pricePKSeparateView() {
    return Expanded(
        flex: 2,
        child: Image.asset(
            '${AssetHotelImagePath}hotel_list_pk_separator@3x.webp'));
  }

  Widget priceSeparatorPK() {
    return Container(
      padding:
          const EdgeInsets.only(left: Dimens.gap_dp1, right: Dimens.gap_dp1),
      child: Image.asset(
          '${AssetHotelImagePath}hotel_list_all_price_separator@3x.webp',
          height: Dimens.gap_dp9),
    );
  }

  // 预订 剩余房间
  Widget bookingText() {
    var bookingString = hotel!.hotelAddInfo!.lastBookingOrder ?? '';
    var roomNumRemark = "";
    var textVisible = Util.isNotEmptyString(bookingString) ||
        Util.isNotEmptyString(roomNumRemark);
    var textColor = Colors.white;
    var text = "";
    if (Util.isNotEmptyString(roomNumRemark)) {
      text = roomNumRemark;
      textColor = HotelColors.hotel_list_num_remark_color;
    } else if (Util.isNotEmptyString(bookingString)) {
      text = bookingString;
      textColor = HotelColors.gray9;
    }
    return Visibility(
      visible: textVisible,
      child: Padding(
        padding: const EdgeInsets.only(top: Dimens.gap_dp3),
        child: Text(
          text,
          style: TextStyle(
              color: fullRoomColor() ?? textColor,
              fontSize: Dimens.font_sp10,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  // 甩卖
  Widget _reductionSaleView() {
    const endTime = '';
    if (endTime.isNotEmpty && isStudentPriceShow()) {
      return Container();
    } else {
      return Container();
      // return hotelListTopRemark();
    }
  }

  // 口碑
  Widget hotelListTopRemark() {
    var topRemark = '';
    return Visibility(
        visible: Util.isNotEmptyString(topRemark),
        child: Container(
          padding: const EdgeInsets.only(right: 5, bottom: 2),
          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: Dimens.gap_dp3),
                child: Image(
                  image: AssetImage(
                      "${AssetHotelImagePath}hotel_list_bangdan_left@3x.webp"),
                  width: Dimens.gap_dp5,
                  height: Dimens.gap_dp12,
                ),
              ),
              Flexible(
                child: Text(
                  topRemark,
                  maxLines: 1,
                  // softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: HotelColors.hotel_list_top_remark_color,
                      fontSize: Dimens.font_sp11,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: Dimens.gap_dp3),
                child: Image(
                  image: AssetImage(
                      "${AssetHotelImagePath}hotel_list_bangdan_right@3x.webp"),
                  width: Dimens.gap_dp5,
                  height: Dimens.gap_dp12,
                ),
              ),
            ],
          ),
        ));
  }

  // 学生价格
  Widget _studentPriceView(String? normalPrice, String studentPrice, String unit,
      String? youthIcon, String? fontColor) {
    final color = ColorUtil.string2Color(fontColor);
    return Row(
      children: [
        Column(
          children: [
            Text.rich(TextSpan(children: [
              WidgetSpan(
                  child: Text(
                '¥',
                style: TextStyle(
                    color: fullRoomColor() ?? HotelColors.gray_ad,
                    fontSize: Dimens.font_sp13,
                    fontFamily: 'NumberIconFont'),
              )),
              WidgetSpan(
                child: Text(
                  '$normalPrice',
                  key: Key("id_hotel_list_item_normal_price#$index"),
                  style: TextStyle(
                      color: fullRoomColor() ?? HotelColors.gray_ad,
                      fontSize: Dimens.font_sp15,
                      fontFamily: 'NumberIconFont'),
                ),
              )
            ])),
            Text(
              '普通用户',
              style: TextStyle(
                  color: fullRoomColor() ?? HotelColors.gray_ad,
                  fontSize: Dimens.font_sp10),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.only(right: Dimens.gap_dp4),
          child: Image.asset(
              '${AssetHotelImagePath}hotel_list_price_pk@3x.webp',
              width: 18,
              height: 25),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    '¥',
                    style: TextStyle(
                        color: fullRoomColor() ?? color,
                        fontSize: Dimens.font_sp13,
                        fontFamily: 'NumberIconFont'),
                  ),
                ),
                Container(
                  child: Text(
                    studentPrice,
                    key: Key("id_hotel_list_item_student_price#$index"),
                    style: TextStyle(
                        color: fullRoomColor() ?? color,
                        fontSize: Dimens.font_sp22,
                        fontFamily: 'NumberIconFont'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 1, bottom: 1),
                  child: Text(
                    unit,
                    style: const TextStyle(
                        color: HotelColors.gray9,
                        fontSize: Dimens.font_sp11,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 1),
              child: Image.network(
                youthIcon ?? '',
                width: 56,
                height: 14,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget pricePreferenceInfo(BuildContext context) {
    final promotionList = hotel!.hotelAddInfo!.promotionTagList;
    var text = hotel!.priceInfo!.couponTag ?? '';
    if (promotionList != null && promotionList.isNotEmpty) {
      final name = promotionList.first.text ?? '';
      return GestureDetector(
          onTap: () {
            if (hotel != null &&
                hotel!.hotelAddInfo != null &&
                hotel!.hotelAddInfo!.promotionDetailList != null &&
                hotel!.hotelAddInfo!.promotionDetailList!.length != 0) {
              // showPriceDetail(hotel, context);
            }
          },
          child: promotionPirce(name, text));
    }
    var importantRightIcon = "";
    var extraPrice = hotel!.priceInfo!.extraPrice.toString() ?? "";
    var extraPriceVisible = (hotel!.priceInfo!.extraPrice ?? 0.0) > 0.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Visibility(
            visible: extraPriceVisible,
            child: Text("另付税/费¥$extraPrice",
                key: Key("id_hotel_list_item_extra_price#$index"),
                style: const TextStyle(
                    color: HotelColors.gray6,
                    fontSize: Dimens.font_sp11,
                    fontWeight: FontWeight.normal))),
        Visibility(
            visible: Util.isNotEmptyString(importantRightIcon),
            child: Image.network(importantRightIcon)),
        Visibility(
          visible: hotel != null &&
              hotel!.hotelAddInfo != null &&
              hotel!.hotelAddInfo!.promotionDetailList != null &&
              hotel!.hotelAddInfo!.promotionDetailList!.length != 0,
          child: GestureDetector(
            onTap: () {
              if (hotel != null &&
                  hotel!.hotelAddInfo != null &&
                  hotel!.hotelAddInfo!.promotionDetailList != null &&
                  hotel!.hotelAddInfo!.promotionDetailList!.length != 0) {
                // showPriceDetail(hotel, context);
              }
            },
            child: isNewCustom
                ? newCoustomPromotion(text)
                : Container(
                    key: Key("id_hotel_list_item_price_detail#$index"),
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.gap_dp4, vertical: Dimens.gap_dp2),
                    decoration: BoxDecoration(
                        color: HotelColors.hotel_red.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(Dimens.gap_dp7),
                            topRight: Radius.circular(Dimens.gap_dp8),
                            bottomRight: Radius.circular(Dimens.gap_dp8))),
                    child: Row(
                      children: [
                        Text(
                          text,
                          style: const TextStyle(
                              fontSize: Dimens.font_sp10,
                              color: HotelColors.hotel_red),
                          textAlign: TextAlign.end,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: Dimens.gap_dp2),
                          child: const Icon(HotelIcons.show_more_icon,
                              size: Dimens.font_sp10,
                              color: HotelColors.hotel_red),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget promotionDiscountView(BuildContext context) {
    final tags = hotel!.hotelAddInfo!.promotionDiscountList ?? [];
    final widgets = tags
        .expand(
            (tag) => [promotionDiscountItem(tag), promotionDiscountSeparator()])
        .toList();
    if (widgets.isNotEmpty) {
      widgets.removeLast();
    }
    if ((hotel!.hotelAddInfo!.promotionDetailList!.isEmpty ?? true)) {
      widgets.add(GestureDetector(
        onTap: () {
          if (Util.isEmptyList(hotel!.hotelAddInfo!.promotionDetailList!)) {
            // showPriceDetail(hotel, context);
          }
        },
        child: Container(
          key: Key("id_hotel_list_item_price_detail#$index"),
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp4, vertical: Dimens.gap_dp2),
          decoration:
              BoxDecoration(color: HotelColors.hotel_red.withOpacity(0.1)),
          child: Row(
            children: [
              Text(
                hotel!.priceInfo!.couponTag ?? '',
                style: const TextStyle(
                    fontSize: Dimens.font_sp10,
                    color: HotelColors.hotel_red,
                    height: 1),
                textAlign: TextAlign.end,
              ),
              Container(
                margin: const EdgeInsets.only(left: Dimens.gap_dp1),
                child: const Icon(HotelIcons.show_more,
                    size: Dimens.font_sp8, color: HotelColors.hotel_red),
              )
            ],
          ),
        ),
      ));
    }

    if (widgets.isEmpty) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.only(top: 2),
      height: 14,
      decoration: BoxDecoration(
          border: Border.all(
              color: HotelColors.hotel_list_price_color.withOpacity(0.5),
              width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      child: Row(
        children: widgets,
      ),
    );
  }

  Widget promotionDiscountItem(PromotionDiscountList tagItem) {
    // final textColor = ColorUtil.string2Color(tagItem.textColor  '');
    return Util.isNotEmptyString(tagItem.iconUrl)
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Image.network(
              tagItem.iconUrl ?? '',
              width: 40,
              height: 10,
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              tagItem.text ?? '',
              style: TextStyle(
                  fontSize: Dimens.gap_dp10,
                  color: fullRoomColor() ?? HotelColors.hotel_list_price_color,
                  height: 1.3),
            ),
          );
  }

  Widget promotionDiscountSeparator() {
    return Container(
      width: 0.5,
      height: 10,
      color: HotelColors.hotel_list_price_color.withOpacity(0.5),
    );
  }

  bool isPromotionDiscount() {
    return hotel!.hotelAddInfo!.promotionDiscountList != null;
  }

  /// 新客特惠
  Widget newCoustomPromotion(String text) {
    return Container(
      height: 14,
      key: Key("id_hotel_list_item_price_detail#$index"),
      decoration: BoxDecoration(
          border: Border.all(
              color: HotelColors.hotel_list_price_color.withOpacity(0.4),
              width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 4, right: 3),
              child: Image.asset('${AssetHotelImagePath}nc_tag.png',
                  width: 40, height: 14)),
          Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              color: HotelColors.hotel_red.withOpacity(0.1),
              child: SizedBox(
                height: 14,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 1),
                      child: Text(
                        text,
                        style: const TextStyle(
                            fontSize: 10,
                            color: HotelColors.hotel_red,
                            fontFamily: 'PingFangSC-Regular',
                            height: 1.0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: const Icon(HotelIcons.show_more,
                          size: 6, color: HotelColors.hotel_red),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  /// 周五大促
  Widget promotionPirce(String name, String text) {
    return Row(children: [
      Image.asset(
        '${AssetHotelImagePath}hotel_list_promotion_left@3x.webp',
        height: Dimens.gap_dp15,
      ),
      Column(
        children: [
          Container(
              width: 42,
              color: HotelColors.hotel_list_promotion_color,
              height: Dimens.gap_dp_half),
          Container(
            color: HotelColors.hotel_list_promotion_bg_color,
            height: Dimens.gap_dp14,
            padding: const EdgeInsets.only(right: Dimens.gap_dp2),
            child: Text(
              name,
              style: const TextStyle(
                  color: HotelColors.hotel_list_price_color,
                  fontSize: Dimens.font_sp10,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
              width: 42,
              color: HotelColors.hotel_list_promotion_color,
              height: Dimens.gap_dp_half),
        ],
      ),
      Image.asset(
        '${AssetHotelImagePath}hotel_list_promotion_center@3x.webp',
        height: Dimens.gap_dp15,
      ),
      SizedBox(
        height: Dimens.gap_dp15,
        child: DecoratedBox(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment(0, 0.5),
              end: Alignment(1, 0.5),
              colors: [Color(0xFFFF4D4D), Color(0xFFFE6F40)],
            )),
            child: Text(
              text,
              style: const TextStyle(
                  color: HotelColors.white,
                  fontSize: Dimens.font_sp10,
                  fontWeight: FontWeight.w500),
            )),
      ),
      Image.asset(
        '${AssetHotelImagePath}hotel_list_promotion_right@3x.webp',
        height: Dimens.gap_dp15,
      ),
    ]);
  }

  ///用户点击优惠view，弹出酒店价格详情
  // void showPriceDetail(HotelList hotel, BuildContext context) {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       backgroundColor: Colors.transparent,
  //       context: context,
  //       builder: (context) => HotelPriceDetailDialogWidget(
  //             hotel.hotelAddInfo.promotionDetailList,
  //             hotel.priceInfo.salePrice,
  //             hotel.priceInfo.couponSalePrice,
  //             hotel.priceInfo.maskTag,
  //             () {
  //               this.callBack();
  //             },
  //             isListSource: true,
  //           ));
  // }

  Color? fullRoomColor() {
    return isFullRoom() ? HotelColors.gray9 : null;
  }

  Widget fullRoomItem() {
    var isFull = isFullRoom();
    return Visibility(
        visible: isFull,
        child: const Image(
          image: AssetImage("${AssetHotelImagePath}hotel_ic_full_room@3x.png"),
          width: Dimens.image_width94,
          height: Dimens.image_width94,
        ));
  }

  Widget separator(BuildContext context) {
    if (null != needSeperatorLine) {
      if (needSeperatorLine!) {
        return Container();
      }
    }
    return Container(
      height: 0.5,
      margin: EdgeInsets.only(
          left: logoWidth + Dimens.gap_dp10 + 10, right: Dimens.gap_dp10),
      color: HotelColors.gray_ee,
      child: Container(
        color: HotelColors.gray_ee,
      ),
    );
  }

  bool isFullRoom() {
    return (hotel!.hotelStatus! & 32) == 32;
  }
}
