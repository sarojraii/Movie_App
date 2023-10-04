import 'package:flutter/material.dart';
import 'package:movie_app/view/dashboard.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';

class ProviderList extends StatefulWidget {
  const ProviderList({super.key});

  @override
  State<ProviderList> createState() => _ProviderListState();
}

class _ProviderListState extends State<ProviderList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Consumer<MovieProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    'My List',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 220),
                  child: Text(
                    'No of Item : ${value.movie.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                value.movie.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 250),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Your list is empty',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                              ),
                              Consumer<DashboardProvider>(
                                builder: (context, provider, child) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      provider.selectIndex(1);
                                    },
                                    child: const Icon(Icons.add),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Consumer<MovieProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              itemCount: provider.movie.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 300),
                                        child: IconButton(
                                          onPressed: () {
                                            provider.removeItem(
                                                provider.movie[index]);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 23,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 180,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://image.tmdb.org/t/p/w500/${provider.movie[index].posterPath ?? ''}'),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${provider.movie[index].originalTitle} ",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Vote Average : ${provider.movie[index].voteAverage}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Adult : ${provider.movie[index].adult} ",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Vote Count : ${provider.movie[index].voteCount} ",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Popularity : ${provider.movie[index].popularity} ",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
