typedef OnSuccess = void Function(Map res);
typedef OnError = void Function(int code, String message);

class ApiCallBack {
  OnSuccess? onSuccess;
  OnError? onError;
  ApiCallBack({ this.onSuccess,this.onError});
}