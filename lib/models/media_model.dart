class Medias {
  List<Media> items = new List();

  Medias();

  Medias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final mediaItem = new Media.fromJsonMap(item);

        items.add(mediaItem);
      }
    }
  }
}

class Media {
  String name;
  String url;
  String mediaCode;
  String mediaLogoUrl;
  String posterImage;
  String posterType;
  String information;
  String facebookLink;
  String instagramLink;
  String twitterLink;
  String youtubeLink;
  String mediaSlogan;
  String mediaType;
  String liveLink;
  bool isLive;
  String topic;
  String hashToken;

  Media({
    this.name,
    this.url,
    this.mediaCode,
    this.mediaLogoUrl,
    this.posterImage,
    this.posterType,
    this.information,
    this.facebookLink,
    this.instagramLink,
    this.twitterLink,
    this.youtubeLink,
    this.mediaSlogan,
    this.mediaType,
    this.isLive,
    this.liveLink,
    this.topic,
    this.hashToken,
  });

  Media.fromJsonMap(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    mediaCode = json['mediaCode'];
    mediaLogoUrl = json['mediaLogoUrl'];
    posterImage = json['posterImage'];
    posterType = json['posterType'];
    information = json['information'];
    facebookLink = json['facebookLink'];
    instagramLink = json['instagramLink'];
    twitterLink = json['twitterLink'];
    youtubeLink = json['youtubeLink'];
    mediaSlogan = json['mediaSlogan'];
    mediaType = json['mediaType'];
    isLive = json['isLive'];
    liveLink = json['liveLink'];
    topic = json['topic'];
    hashToken = json['hashToken'];
  }
}
