import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Shimmer/shimmerExplore.dart';
import 'package:movie_app/apipage/moviepage.dart';
import '../model/models.dart';
import '../mobilepage/mobile_homepage.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Result>? explore = [];
  List<Result> searchedItem = [];

  bool _shimmerEffect = true;

  bool get shimmerEffect => _shimmerEffect;

  set shimmerEffect(bool value) {
    setState(() {
      _shimmerEffect = value;
    });
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        searchedItem = explore ?? [];
        setState(() {});
      }
    });
    getData();
  }

  void getData() async {
    shimmerEffect = true;
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
    shimmerEffect = false;
  }

  Future<MovieApi> parseRawData(Map<String, dynamic> apiResponse) async {
    var result = await compute(MovieApi.fromJson, apiResponse);
    return result;
  }

  List<Result> search(String query) {
    List<Result> filterList = [];
    if (explore != null && (explore?.isNotEmpty ?? false)) {
      for (var i = 0; i < explore!.length; i++) {
        if (explore![i].originalTitle?.toLowerCase().contains(query) ?? false) {
          filterList.add(explore![i]);
        }
      }
    }
    return filterList;
  }

  SearchController searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: searchController,
                onChanged: (value) {
                  searchedItem = search(value);
                  setState(() {});
                },
                keyboardType: TextInputType.text,
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
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: RowWidget(),
              ),
              Expanded(
                  child: shimmerEffect
                      ? ShimmerExplore().exploreShimmer()
                      : GridB(
                          movies: searchedItem.isEmpty
                              ? explore ?? []
                              : searchedItem,
                        ))
            ],
          ),
        ),
      ),
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
  final List<Result> movies;
  const GridB({super.key, required this.movies});

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 240,
      ),
      itemCount: widget.movies.length,
      physics: const BouncingScrollPhysics(),
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
                        MoviePage(selectedMovie: widget.movies[index]),
                  ),
                );
              },
              child: Image(
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/w500/${widget.movies[index].posterPath ?? ''}"),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
