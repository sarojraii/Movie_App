import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/provider/provider.dart';
import 'package:provider/provider.dart';
import '../model/models.dart';
import '../mobilepage/mobile_homepage.dart';

const String links =
    "https://api.themoviedb.org/3/movie/popular?key=f8aae75654842e23bf7af7f43fe3c6c2&page=1";

class MoviePage extends StatefulWidget {
  final Result selectedMovie;
  final Result? selectedImage;

  const MoviePage({super.key, required this.selectedMovie, this.selectedImage});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Result>? details = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await Dio().get(links,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      if (response.statusCode == 200) {
        final result = await parseRawData(response.data);
        setState(() {
          details = result.results;
        });
      } else {
        if (kDebugMode) {
          print("response.statuscode: ${response.statusCode}");
        }
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error---");
      }
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<MovieApi> parseRawData(Map<String, dynamic> apiResponse) async {
    var result = await compute(MovieApi.fromJson, apiResponse);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [ConsumerWidget(widget: widget)],
          backgroundColor: Colors.blueGrey[900],
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              widget.selectedMovie.originalTitle ?? '',
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Stack(
              children: [
                ImageWidget(widget: widget),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        widget.selectedMovie.voteAverage.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      'Released Date :',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.selectedMovie.releaseDate != null
                          ? DateFormat('yyyy-MM-dd')
                              .format(widget.selectedMovie.releaseDate!)
                          : 'N/A',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      'Adult : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      widget.selectedMovie.adult == true ? 'Yes' : 'No',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Story Line',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            StoryDescriptionWidget(widget: widget),
          ],
        ),
      ),
    );
  }
}

class ConsumerWidget extends StatefulWidget {
  const ConsumerWidget({
    super.key,
    required this.widget,
  });

  final MoviePage widget;

  @override
  State<ConsumerWidget> createState() => _ConsumerWidgetState();
}

class _ConsumerWidgetState extends State<ConsumerWidget> {
  bool _changer = false;

  bool get changer => _changer;

  set changer(bool value) {
    _changer = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, Provider, child) {
        return Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Consumer<MovieProvider>(
            builder: (context, provider, child) {
              return IconButton(
                onPressed: () {
                  changer = !changer;
                  !provider.movie.contains(widget.widget.selectedMovie)
                      ? provider.addItem(widget.widget.selectedMovie)
                      : provider.removeItem(widget.widget.selectedMovie);
                },
                icon: child ?? const SizedBox(),
              );
            },
            child: !Provider.movie.contains(widget.widget.selectedMovie)
                ? const Icon(Icons.add_circle_outlined)
                : const Icon(Icons.check_circle_rounded),
          ),
        );
      },
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.widget,
  });

  final MoviePage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      height: 350,
      width: double.infinity,
      child: Image(
        image: NetworkImage(
            "https://image.tmdb.org/t/p/w500/${widget.selectedMovie.posterPath ?? ''}"),
        fit: BoxFit.contain,
      ),
    );
  }
}

class StoryDescriptionWidget extends StatelessWidget {
  const StoryDescriptionWidget({
    super.key,
    required this.widget,
  });

  final MoviePage widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              widget.selectedMovie.overview ?? '',
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }
}
