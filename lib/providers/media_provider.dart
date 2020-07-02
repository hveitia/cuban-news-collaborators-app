import 'dart:async';
import 'dart:convert';
import 'package:collaborators_app/models/media_model.dart';
import 'package:http/http.dart' as http;
import 'configs_providers.dart';

class MediaProvider {
  final configProvider = ConfigsProvider();

  Future<List<Media>> _proccesResponse(Uri url) async {
    final response = await http.get(url);

    final decodedData = json.decode(response.body);

    final medias = new Medias.fromJsonList(decodedData['data']);

    return medias.items;
  }

  Future<List<Media>> getMedias() async {
    final url = configProvider.getEnvironment() == 'prod'
        ? Uri.https(configProvider.getUrl(), '/api/media-youtube')
        : Uri.http(configProvider.getUrl(), '/api/media-youtube');

    return await _proccesResponse(url);
  }

  Future<dynamic> setLiveTransmition(dynamic data) async {

    final url = configProvider.getEnvironment() == 'prod'
        ? Uri.https(configProvider.getUrl(), '/api/media/${data['hashToken']}')
        : Uri.http(configProvider.getUrl(), '/api/media/${data['hashToken']}');

    final payload = {
      'liveLink': '${data['liveLink']}',
      'starLive': "23/03/2020 11:02:06",
      'endLive': "23/03/2020 12:02:06",
      'liveDuration': data['liveDuration']
    };

    return await http.put(url, body: payload);

  }
}
