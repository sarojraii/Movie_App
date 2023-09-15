import 'package:flutter/material.dart';
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
    return SafeArea(child: Scaffold(
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.movie.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        provider.removeItem(provider.movie[index]);
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 150),
                        child: Icon(Icons.delete),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 230,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${provider.movie[index].posterPath ?? ''}'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${provider.movie[index].originalTitle} ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${provider.movie[index].overview}",
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    ));
  }
}
