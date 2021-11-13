import 'dart:convert';

import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_convert.dart';
import 'package:nasa_clean_arch/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

import 'endpoints/nasa_endpoints.dart';

class NasaDatasourceImplementation implements ISpaceMediaDatasource {
  final HttpClient client;

  NasaDatasourceImplementation(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    String url = NasaEndpoints.apod(
        NasaApiKeys.apiKeys, DateToStringConvert.convert(date));

    final response = await client.get(url);
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
