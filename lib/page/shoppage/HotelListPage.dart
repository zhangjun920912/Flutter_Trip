
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../base/network/api_call_back.dart';
import '../../base/network/hotel_services.dart';
import 'component/HotelListItem.dart';
import 'model/HotelListModel.dart';

///
///@desc:
///@author: jzhang28
///@date: 2022年06月21 17点16分，Tuesday
///

class HotelListPage extends StatefulWidget {
  const HotelListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HotelListPageState();
}

class HotelListPageState extends State<HotelListPage> {

  List<HotelList> listSearchData = [];

  ScrollController scrollController = ScrollController();

  bool isLoading = false;


  HotelListPageState();

  @override
  // ignore: must_call_super
  void initState() {
    loadFirstPageData();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        loadNextPageData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('酒店列表页'),
          actions: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 12),
              child: isLoading?getLoadingWidget():Container(),
            ),
          ],
        ),
        body: SizedBox(
            child: Container(
          child: getContentWidget(),
        )));
  }

  ///获取内容组件
  Widget getContentWidget() {
    return RefreshIndicator(
      onRefresh: () async {
        refreshPageData();
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listSearchData.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          return HotelListItemWidget(
            false,
            key: Key("id_hotel_list_item#$index"),
            hotel: listSearchData[index],
            index: index,
            isOverseas: false,
            isMapTopHotel: false,
            callBack: (){

            },
          );
        },
      ),
    );
  }

  ///获取加载组件
  Widget getLoadingWidget() {
    return Row(
      children: const [
        CupertinoActivityIndicator(animating: true,),
        Text(' Loading...')
      ],
    );
  }

  ///加载数据
  void loadPageData() async{
    HotelServices.getHotelList(
        {},
        ApiCallBack(
            onSuccess: (Map response) {
              final listModel = HotelListModel.fromJson(response).data!;
              if(listModel.hotelList!.isNotEmpty) {
                listSearchData.addAll(listModel.hotelList!);
                if(mounted) {
                  setState(() {
                    listSearchData = listSearchData;
                    isLoading = false;
                  });
                }
              }
            },
            onError: (int code, String message) {}));
  }

  ///下拉刷新数据
  void refreshPageData() {
    if(mounted) {
      setState(() {
        isLoading = true;
        listSearchData = [];
      });
    }
    Future.delayed(const Duration(milliseconds: 500), () => loadPageData());
  }

  ///加载下一页数据
  void loadNextPageData() {
    if(mounted) {
      setState(() {
        isLoading = true;
      });
    }
    Future.delayed(const Duration(milliseconds: 500), () => loadPageData());
  }

  ///加载第一页数据
  void loadFirstPageData() {
    Future.delayed(const Duration(milliseconds: 200), () => loadPageData());
  }
}
