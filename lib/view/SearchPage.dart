import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mobilecomputing/Serivces/WeatherServices.dart';
import 'package:mobilecomputing/models/WeatherModel.dart';
import 'package:mobilecomputing/view/OnBoarding.dart';
import 'package:mobilecomputing/view/searched_city.dart';
import '../widgets/city_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController? _searchController;

  //late WeatherModel weather;
  final List<String> cities = [
    'Fayoum',
    'Australia',
    'Moscow',
    'Alex',
    'Brazil',
    'Cairo',
    'Zagazig',
    'Beni-Suef',
    'Menia',
    'Luxor',
    'Hurghada',
    'Giza',
    'Aswan',
    'Port Said',
    'Kafr el-Sheikh',
    'Suez',
    'Sohag',
    'Qena',
    'Helwan',
    'Banha',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  Future<WeatherModel?> fetchWeather(String city) async {
    try {
      WeatherModel fetchedWeather =
          await WeatherServices(Dio()).GetWeather(city: city);
      return fetchedWeather;
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OnBoarding(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 22,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Weather",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for a city",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    WeatherModel? fetchedWeather =
                        await fetchWeather(_searchController!.text);
                    if (fetchedWeather != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SearchedCity(weather: fetchedWeather),
                        ),
                      );
                    } else {
                      // Show alert dialog for invalid city
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('City not found!'),
                          content: Text('Please enter a valid city name.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return CityCard(
                    currentCity: cities[index],
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
