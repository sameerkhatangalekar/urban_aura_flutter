import 'package:urban_aura_flutter/features/search/domain/repository/search_repository.dart';

final class SearchProductUsecase {
  final SearchRepository _searchRepository;

  SearchProductUsecase({required SearchRepository searchRepository})
      : _searchRepository = searchRepository;

  void call(String param) {
    return _searchRepository.search(query: param);
  }
}
