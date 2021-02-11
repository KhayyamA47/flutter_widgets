import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_example/mainUtil.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(
  DevicePreview(
    builder: (context) => MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widgets',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // builder: DevicePreview.appBuilder,

      home: MyHomePage(title: 'Widgets'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 3, vsync: this);

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();

  }
  final europeanCountries = ['Albania', 'Andorra', 'Armenia', 'Austria',
    'Azerbaijan', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria',
    'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland',
    'France', 'Georgia', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland',
    'Italy', 'Kazakhstan', 'Kosovo', 'Latvia', 'Liechtenstein', 'Lithuania',
    'Luxembourg', 'Macedonia', 'Malta', 'Moldova', 'Monaco', 'Montenegro',
    'Netherlands', 'Norway', 'Poland', 'Portugal', 'Romania', 'Russia',
    'San Marino', 'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Sweden',
    'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican City'];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.widgets),
              ),
              Tab(
                icon: Icon(Icons.list),
              ),
              Tab(
                icon: Icon(Icons.grid_on),
              ),
            ]),
      ),
      body: TabBarView(
        children: <Widget>[
          NestedTabBar(),
          Center(
            child: ListView.builder(
              itemCount: europeanCountries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(europeanCountries[index]),
                );
              },
            ),
          ),
          Center(
            child: GridView.count(
              crossAxisCount: 4,
              children: new List<Widget>.generate(88, (index) {
                return new GridTile(
                  child: new Card(
                      color: Colors.blue.shade200,
                      child: new Center(
                        child: new Text('tile $index'),
                      )
                  ),
                );
              }),
            ),
          )
        ],
        controller: _tabController,
      ),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  VideoPlayerController _controller;
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 5, vsync: this);

    _controller = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

  }

  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
    _controller.dispose();
  }
  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;

      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;

      });
      print('Switch Button is OFF');
    }
  }
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TabBar(
            controller: _nestedTabController,
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: "Text",
              ),
              Tab(
                text: "Buttons",
              ),
              Tab(
                text: "Textfiled",
              ),
              Tab(
                text: "Images",
              ),
              Tab(
                text: "Video",
              ),

            ],
          ),
          Container(
            height: screenHeight * 0.70,
            margin: EdgeInsets.only(left: SizeConfig.size16, right: SizeConfig.size16),
            child: TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.size8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.size25),
                      Text('Normal text',
                          style: TextStyle(
                              fontSize: SizeConfig.size25,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: SizeConfig.size25),
                      Text('Light text',
                          style: TextStyle(
                              fontSize: SizeConfig.size25,
                              color: Colors.black,
                              fontWeight: FontWeight.w100)),
                      SizedBox(height: SizeConfig.size25),
                      Text('Bold text',
                          style: TextStyle(
                              fontSize: SizeConfig.size25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: SizeConfig.size25),
                      Text('Italic text',
                          style: TextStyle(
                              fontSize: SizeConfig.size25,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.size8),
                  ),
                  child:SingleChildScrollView(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.size25),
                        RaisedButton(
                          child: Text(
                            "Raised Button",
                            style: TextStyle(fontSize: SizeConfig.size20),
                          ),
                          onPressed: () {},
                          color: Colors.red,
                          textColor: Colors.yellow,
                          padding: EdgeInsets.all(SizeConfig.size8),
                          splashColor: Colors.grey,
                        ),
                        SizedBox(height: SizeConfig.size25),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(SizeConfig.size18),
                              side: BorderSide(color: Colors.red)),
                          child: Text(
                            "Oval Raised Button",
                            style: TextStyle(fontSize: SizeConfig.size20),
                          ),
                          onPressed: () {},
                          color: Colors.green,
                          textColor: Colors.yellow,
                          padding: EdgeInsets.all(SizeConfig.size8),
                          splashColor: Colors.grey,
                        ),
                        SizedBox(height: SizeConfig.size25),
                        FloatingActionButton(
                          child: Icon(Icons.navigation),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          onPressed: () => {},
                        ),
                        SizedBox(height: SizeConfig.size25),
                        FloatingActionButton.extended(
                          onPressed: () {},
                          icon: Icon(Icons.save),
                          label: Text("Save"),
                        ),
                        SizedBox(height: SizeConfig.size25),
                        IconButton(
                          icon: Icon(Icons.volume_up),
                          iconSize: 50,
                          color: Colors.brown,
                          tooltip: 'Increase volume by 5',
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                        SizedBox(height: SizeConfig.size25),
                        OutlineButton(
                          child: Text(
                            "Outline Button",
                            style: TextStyle(fontSize: SizeConfig.size20),
                          ),
                          highlightedBorderColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(SizeConfig.size15)),
                          onPressed: () {},
                        ),
                        SizedBox(height: SizeConfig.size25),
                        Switch(
                          onChanged: toggleSwitch,
                          value: isSwitched,
                          activeColor: Colors.blue,
                          activeTrackColor: Colors.yellow,
                          inactiveThumbColor: Colors.redAccent,
                          inactiveTrackColor: Colors.orange,
                        )

                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.size8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.size25),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Text Filed with Label',
                        ),
                      ),
                      SizedBox(height: SizeConfig.size25),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Text Filed without Label',
                        ),
                      ),
                      SizedBox(height: SizeConfig.size25),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Text Filed without decoration',
                        ),
                      ),
                      SizedBox(height: SizeConfig.size25),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Text Filed with secure',
                        ),
                      ),
                      SizedBox(height: SizeConfig.size25),
                      TextField(
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(SizeConfig.size20),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "Oval TextFiled",
                            fillColor: Colors.white70),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.size8),
                  ),
                  child:SingleChildScrollView(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.size25),
                        Image.network(
                            'https://www.scisports.com/wp-content/uploads/2019/06/Bayern-visual-1920-logo-1280x720.jpg'),
                        Text('Image from network',
                            style: TextStyle(
                                fontSize: SizeConfig.size25,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: SizeConfig.size25),
                        Image.asset(
                            'assets/image.jpg'),
                        Text('Image from asset',
                            style: TextStyle(
                                fontSize: SizeConfig.size25,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: SizeConfig.size25),
                        CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage('https://tmssl.akamaized.net/images/wappen/head/36.png?lm=1406739123')
                        ),
                        Text('Circle Image',
                            style: TextStyle(
                                fontSize: SizeConfig.size25,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: SizeConfig.size25),
                        Container(
                          width: SizeConfig.screenWidth*0.7,
                          height: SizeConfig.screenHeight*0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage('https://blog.playstation.com/tachyon/2019/09/48790616681_d85d6013dd_o.jpg?resize=1088,612&crop_strategy=smart')),
                            borderRadius: BorderRadius.all(Radius.circular(SizeConfig.size8)),
                            color: Colors.white,
                          ),
                        ),
                        Text('Oval corner image',
                            style: TextStyle(
                                fontSize: SizeConfig.size25,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.size8),

                  ),
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.size25),
                      _controller.value.initialized
                          ? Container(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      )
                          : Container(),
                      SizedBox(height: SizeConfig.size25),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        child: Icon(
                          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
