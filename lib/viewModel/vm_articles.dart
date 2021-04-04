import 'package:vaccine_hk/data/entities.dart';
import 'package:vaccine_hk/data/remote/index.dart';
import 'package:vaccine_hk/data/remote/remote_article_list.dart';

class ArticlesPageViewModel {
  static Future<List<IPost>> getArticles({ int page = 1 }) async {
    List<IPost> response = await RemoteArticles.getArticels(page: page);
    return response;
  }
}
