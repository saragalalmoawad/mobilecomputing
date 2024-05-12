import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobilecomputing/view/Settings.dart';

import '../widgets/dtails-card.dart';
import 'SearchPage.dart';
import 'details_page.dart';

class CityPage extends StatefulWidget {
  final String currentCity;
  final String currentCountry;
  final String currentDate;
  final double currentTemperature;
  final String currentCondition;
  final double currentVisibility;
  final double currentWind;
  final num currentRain;
  final int currentSnow;
  final int currentClouds;
  final double currentPressure;
  final num currentUV;
  final num currentHumidity;
  final String background;
  final String sunrise;
  final String sunset;

  CityPage({
    super.key,
    required this.currentUV,
    required this.currentCity,
    required this.currentCountry,
    required this.currentDate,
    required this.currentTemperature,
    required this.currentCondition,
    required this.currentWind,
    required this.currentRain,
    required this.currentSnow,
    required this.currentClouds,
    required this.currentHumidity,
    required this.background,
    required this.currentPressure,
    required this.currentVisibility,
    required this.sunrise,
    required this.sunset,
  });

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  @override
  Widget build(BuildContext context) {
    //****************************extract date from api date without time
    String timeString = '${widget.currentDate}';
    DateTime dateTime = DateTime.parse(timeString);
    String formattedDate =
        "${dateTime.day}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString().padLeft(2, '0')}";
    print(
        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.${formattedDate}"); // Output: 2024-04-25
    //*********************************************************************

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ));
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 27,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Settings(),
                          ));
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 30,
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
                Column(
                  children: [
                    Text(
                      "${widget.currentCity},",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.currentCountry}",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text(
                      "${formattedDate}" ?? '---',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                //SizedBox(width: MediaQuery.of(context).size.width*.25,),
                Spacer(),
                Image.asset("assets/im2.png")
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: AssetImage(widget.background),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Image.asset(
                        "assets/im4.png",
                        width: 130,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.currentCondition}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${widget.currentTemperature}°C",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailsCard(
                  imagePath: 'assets/im6.png',
                  text: '${widget.currentRain}%',
                ),
                DetailsCard(
                  imagePath: 'assets/im5.png',
                  text: '${widget.currentWind}km/h',
                ),
                DetailsCard(
                  imagePath: 'assets/im7.png',
                  text: '${widget.currentClouds}%',
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .12,
            ),
            Container(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          city: '${widget.currentCity}',
                          uv: widget.currentUV,
                          humidity: widget.currentHumidity,
                          wind: widget.currentWind,
                          pressure: widget.currentPressure,
                          clouds: widget.currentClouds,
                          Temperature: widget.currentTemperature,
                          visibility: widget.currentVisibility,
                          condition: '${widget.currentCondition}',
                          sunrise: '${widget.sunrise}',
                          sunset: '${widget.sunset}',
                        ),
                      ));
                },
                child: Text(
                  "More Details",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.amber),
              ),
            )
          ],
        ),
      ),
    );
  }
}
