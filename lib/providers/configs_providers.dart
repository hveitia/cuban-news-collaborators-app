class ConfigsProvider {

  final _activeEnvironment = 'prod'; //prod
  Map<String, String> _environmentUrl = {
      'dev': '192.168.200.2:3000',
      'prod': 'cuban-news.com'
  };
  
  getUrl(){
    return _environmentUrl[_activeEnvironment];
  }

  getEnvironment(){
    return _activeEnvironment;
  }
}