import 'package:assistance/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'Weather_client.dart';
import 'models/models.dart';
import 'slide_digital_clock.dart';
import 'package:http/http.dart' as http;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays ([]);
  Wakelock.enable();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then((_){
    runApp(MyApp());
  });

}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: Clock(),
      ),
    );
  }
}
class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Weather weather;
  WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  Future<Weather> get()async{
    Weather _weather = await weatherRepository.getWeather('kolkata');
    setState(() {
      weather = _weather;
    });
    return _weather;
  }
  @override
  void initState(){
    get();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    print(width);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height:height*0.65,
                  width:width*0.6,
                  margin: EdgeInsets.only(top:20,left: 20),
                  child: DigitalClock(
                    digitAnimationStyle: Curves.elasticOut,
                    is24HourTimeFormat: false,
                    areaDecoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    hourMinuteDigitTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: width/5.7,
                    ),
                    secondDigitTextStyle: TextStyle(
                      color: Colors.white70,
                      fontSize:width/16,
                    ),
                    amPmDigitTextStyle: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: width/25
                    ),
                  ),
                ),
                Container(
                 // child: Text(weather.formattedCondition.toString(),style: TextStyle(color: Colors.white70),),
                )
              ],
            ),
            Container(
              width:width*0.4-20,
              child:Container(
                    padding: EdgeInsets.all(20),
                    margin:EdgeInsets.only(top:20,left: 10,right: 10),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: [
                        SizedBox(
                          height:width*0.2,
                          width: width*0.2,
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(Icons.wifi,color: Colors.white70,size:width*0.05,),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border:Border.all(color: Colors.white70,width:3),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                        ),
                        SizedBox(
                          height:width*0.2,
                          width: width*0.2,
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(Icons.apps,color: Colors.white70,size:width*0.05,),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border:Border.all(color: Colors.white70,width:3),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                        ),
                        SizedBox(
                          height: width*0.2,
                          width: width*0.2,
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(Icons.music_note,color: Colors.white70,size:width*0.05,),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border:Border.all(color: Colors.white70,width:3),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                        ),
                        SizedBox(
                          height: width*0.2,
                          width: width*0.2,
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(Icons.power_settings_new,color: Colors.white70,size:width*0.05,),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border:Border.all(color: Colors.white70,width:3),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
