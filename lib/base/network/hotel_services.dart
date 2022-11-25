
import 'api_call_back.dart';
import 'data_file.dart';

///酒店API请求
class HotelServices {
  static String getBaseUrl() {
    var url = "https://m.ctrip.com/restapi/soa2/";
    var env = 'prod';
    var useHttps = true;
    if (!useHttps) {
      url = 'http://m.ctrip.com/restapi/soa2/';
    }
    if (env == 'uat') {
      url = 'http://m.uat.ctripqa.com/restapi/soa2/';
    } else if (env == 'fat') {
      url = 'http://m.fat.ctripqa.com/restapi/soa2/';
    }
    return url;
  }


  static getTyHotelDetail(Map<String, dynamic> param, ApiCallBack apiCallBack) {
    var actionName = 'GetTyHotelDetail';
    var url = '${getBaseUrl()}14784/json/$actionName';
  }


  static getTyHotelRoomPrice(
      Map<String, dynamic> param, ApiCallBack apiCallBack) {
    var url = '${getBaseUrl()}14784/json/getTyHotelRoomPrice';
  }


  /// 获取酒店列表
  static getHotelList(Map<String, dynamic> param, ApiCallBack apiCallBack,
      {String? sequenceId}) {
    String string =
    param['hotelType'] == 2 ? "overseaHotelListSearch" : 'hotelListSearch';
    var url = '${getBaseUrl()}14784/json/$string';
    apiCallBack.onSuccess!(DataFile.getListSearchData());

  }
}

