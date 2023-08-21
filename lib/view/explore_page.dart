import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/apipage/moviepage.dart';

import '../model/models.dart';
import 'home_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GridA(
                      text: 'Action',
                    ),
                    GridA(
                      text: 'Adventure',
                    ),
                    GridA(
                      text: 'Horror',
                    ),
                    GridA(
                      text: 'Sci-fi',
                    ),
                    GridA(
                      text: 'Comedy',
                    ),
                    GridA(
                      text: 'Thriller',
                    ),
                  ],
                ),
              ),
              Expanded(child: GridB())
            ],
          ),
        ),
      ),
    );
  }
}

class GridA extends StatelessWidget {
  final String text;

  const GridA({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class GridB extends StatefulWidget {
  const GridB({super.key});

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  // final List<Map<String, dynamic>> gridMap = [
  //   {
  //     "images": "image/captain.jpg",
  //   },
  //   {
  //     "images": "image/gog.jpg",
  //   },
  //   {
  //     "images": "image/fast.jpg",
  //   },
  //   {
  //     "images": "image/panther.jpg",
  //   },
  //   {
  //     "images": "image/captain.jpg",
  //   },
  //   {
  //     "images": "image/gog.jpg",
  //   },
  //   {
  //     "images": "image/fast.jpg",
  //   },
  //   {
  //     "images": "image/panther.jpg",
  //   },
  // ];

  List<Result>? explore = [];
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
          explore = result.results;
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
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 240,
        ),
        itemCount: explore?.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.redAccent.shade100,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MoviePage(selectedMovie: explore![index]),
                    ),
                  );
                },
                child: Image(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500/${explore?[index].posterPath ?? ''}"),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        });
  }
}
