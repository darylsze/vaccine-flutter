export 'remote_center_list.dart';
export 'remote_vaccines_entity.dart';
export 'remote_article_list.dart';

class Result<T> {
}

class Success<T> extends Result<T> {
  late T data;

  Success(this.data);

}

class Error<T> extends Result<T> {
  Error();
}
