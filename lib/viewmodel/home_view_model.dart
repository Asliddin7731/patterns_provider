
import 'package:flutter/cupertino.dart';

import '../model/post_model.dart';
import '../service/http_service.dart';

class HomeViewModel extends ChangeNotifier{
  bool isLoading = false;
  List<Post> items = [];

  Future apiPostList() async {
    isLoading = true;
    notifyListeners();
    var response = await Network.GET(Network.apiList, Network.paramsEmpty());
      if (response != null) {
        items = Network.parsePostList(response);
      } else {
        items = [];
      }
      isLoading = false;
      notifyListeners();
  }

  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();

    var response = await Network.DEl(Network.apiDelete + post.id.toString(), Network.paramsEmpty());

    isLoading = false;
    notifyListeners();

    return response != null;
  }

}