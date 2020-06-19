import 'package:collaborators_app/models/media_model.dart';
import 'package:collaborators_app/providers/media_provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Collaborators tool.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _youtubeLink = '';
  String _duration = '1';
  String _selectedChanell = '';

  List<Media> _channelList = [];
  List<String> _durationList = ['1', '2', '3'];

  final mediaProvider = new MediaProvider();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          FutureBuilder(
              future: mediaProvider.getMedias(),
              builder: (BuildContext context, AsyncSnapshot<List<Media>> snapshot) {
                
                if (snapshot.hasData) {
                   
                   List<String> list = [];

                   _channelList = snapshot.data;
                   
                   for(var i = 0; i < snapshot.data.length; i++){

                     list.add(snapshot.data[i].name);

                   }

                  if(_selectedChanell == ''){

                    _selectedChanell = list[0];
                  }
                    
                   return  _createChanellDropDown(list);

                } else {

                  return Container();

                }
              },
            ),
          Divider(),
          _createDurationDropDown(),
          Divider(),
          _createInput()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

            String hash = '';
            for(var i = 0; i < _channelList.length; i++){
              if(_channelList[i].name == _selectedChanell){
                  hash = _channelList[i].hashToken;
                  break;
              }
            }

            final data = {

                'hashToken': hash,
                'liveLink': _youtubeLink,
                'liveDuration': _duration

            };

            mediaProvider.setLiveTransmition(data);

        },
        child: Icon(Icons.send),
      ),
    );
  }

  Widget _createInput() {
    return TextField(
      autofocus: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Insert Youtube link',
          labelText: 'Link',
          icon: Icon(Icons.video_library)),
      onChanged: (value) {
        setState(() {
          _youtubeLink = value;
        });
      },
    );
  }

  Widget _createChanellDropDown(List<String> listToshow) {
    return Row(
      children: <Widget>[
        Icon(Icons.person_pin),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _selectedChanell,
            items: _getChanellDropDownOptions(listToshow),
            onChanged: (selectedValue) {
              setState(() {
                _selectedChanell = selectedValue;
              });
            },
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> _getChanellDropDownOptions(List<String> listToshow) {
    
  List<DropdownMenuItem<String>> list = new List();

    listToshow.forEach((ch) {
      list.add(DropdownMenuItem(
        child: Text(ch),
        value: ch,
      ));
    });

    return list;
  }

  Widget _createDurationDropDown() {
    return Row(
      children: <Widget>[
        Icon(Icons.timer),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _duration,
            items: _getDurationDropDownOptions(),
            onChanged: (selectedValue) {
              setState(() {
                _duration = selectedValue;
              });
            },
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> _getDurationDropDownOptions() {
    List<DropdownMenuItem<String>> list = new List();

    _durationList.forEach((d) {
      list.add(DropdownMenuItem(
        child: Text(d),
        value: d,
      ));
    });

    return list;
  }


}
