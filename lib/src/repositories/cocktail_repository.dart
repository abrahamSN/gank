import '../models/models.dart';

import '../utils/utils.dart';

class CocktailRepository {
  Future<CocktailModel> getAll() async {
    ApiClient apiClient = ApiClient();
      try {
        Map<String, dynamic> data = {
          'path': 'search.php',
          'queryParam': {
            's': 'a',
          },
        };

        final res = await apiClient.get(data);

        return CocktailModel.fromJson(res.data);
      } catch(e) {
        return e;
      }
  }
}