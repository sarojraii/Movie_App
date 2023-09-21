import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/apipage/moviepage.dart';
import '../model/models.dart';

const String token =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmOGFhZTc1NjU0ODQyZTIzYmY3YWY3ZjQzZmUzYzZjMiIsInN1YiI6IjYzZWNjMjA2MWI3Mjk0MDA3YzRhMjg0ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.23lyMgfIqLej3W_DlkWcUnd0BMjIESDGtacHVBwz8fg";

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  List<Result>? movies = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/popular?key=f8aae75654842e23bf7af7f43fe3c6c2&page=1',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      if (response.statusCode == 200) {
        final result = await parseRawData(response.data);
        setState(() {
          movies = result.results;
        });
      } else {
        print("response.statuscode: ${response.statusCode}");
        print(response.statusCode);
      }
    } catch (e) {
      print("error---");
      print(e);
    }
  }

  Future<MovieApi> parseRawData(Map<String, dynamic> apiResponse) async {
    var result = await compute(MovieApi.fromJson, apiResponse);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CarouserlSliderWidget(),
              const SizedBox(
                height: 10,
              ),
              const TextWidget(),
              const SizedBox(
                height: 5,
              ),
              ImageWidget(movies: movies),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: RowWidget(),
              ),
              const SizedBox(
                height: 10,
              ),
              SecondImageWidget(movies: movies),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondImageWidget extends StatelessWidget {
  const SecondImageWidget({
    super.key,
    required this.movies,
  });

  final List<Result>? movies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 230,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: movies?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                    height: 230,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoviePage(
                              selectedMovie: movies![index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500/${movies?[index].posterPath ?? ''}"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(5),
                      ),
                    ));
              }),
        ),
      ],
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'New Release',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Text(
          'See all',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ],
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.movies,
  });

  final List<Result>? movies;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 230,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: movies?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                    height: 230,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoviePage(
                              selectedMovie: movies![index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500/${movies?[index].posterPath ?? ''}"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(5),
                      ),
                    ));
              }),
        ),
      ],
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Popular',
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            'See all',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class CarouserlSliderWidget extends StatelessWidget {
  const CarouserlSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: const [
        Stacker(
          text: 'Black Panther',
          text2: 'Superhero, Action, Adventure',
          text3: 'Play',
          text4: '+ List',
          imagePath: 'image/panther.jpg',
        ),
        Stacker(
          text: 'Guardian of Galaxy',
          text2: 'Superhero, Action, Adventure',
          text3: 'Play',
          text4: '+ List',
          imagePath: 'image/gog.jpg',
        ),
        Stacker(
          text: 'Captain America',
          text2: 'Superhero, Action, Adventure',
          text3: 'Play',
          text4: '+ List',
          imagePath: 'image/captain.jpg',
        ),
        Stacker(
          text: 'Fast & Furious X',
          text2: 'Superhero, Action, Adventure',
          text3: 'Play',
          text4: '+ List',
          imagePath: 'image/fast.jpg',
        ),
      ],
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        height: 250,
        enableInfiniteScroll: true,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInBack,
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }
}

class Stacker extends StatefulWidget {
  final String text;
  final String text2;
  final String text3;
  final String text4;
  final String imagePath;

  const Stacker({
    super.key,
    required this.text,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.imagePath,
  });

  @override
  State<Stacker> createState() => _StackerState();
}

class _StackerState extends State<Stacker> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.imagePath), fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: 135,
          left: 10,
          child: Text(
            widget.text,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: 160,
          left: 10,
          child: Text(
            widget.text2,
            style: const TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
        Positioned(
          top: 190,
          left: 10,
          child: Row(
            children: [
              Container(
                height: 27,
                width: 85,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.red),
                child: Center(
                  child: Text(
                    widget.text3,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                height: 27,
                width: 85,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.white)),
                child: Center(
                  child: Text(
                    widget.text4,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
