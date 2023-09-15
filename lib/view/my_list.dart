import 'package:flutter/material.dart';

import '../model/models.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List<String> toDos = [];

  final TextEditingController _searchController = TextEditingController();

  void _addToDOItem(String toDOText) {
    setState(() {
      toDos.add(toDOText);
    });
  }

  void updateItem(int index, String updatedItem) {
    setState(() {
      toDos[index] = updatedItem;
    });
  }

  bool _isUpdate = false;
  bool get isUpdate => _isUpdate;

  set isUpdate(bool value) {
    _isUpdate = value;
    setState(() {});
  }

  var selectedIndex = 0;

  List<Result> movies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textFormField(),
                  const SizedBox(
                    height: 10,
                  ),
                  isUpdate
                      ? Container()
                      : InkWell(
                          onTap: () {
                            _searchController.text.isEmpty
                                ? ''
                                : _addToDOItem(_searchController.text);
                            _searchController.clear();
                          },
                          child: Container(
                            height: 60,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  isUpdate ? updateButton() : Container(),
                  Text(
                    'Total Item : ${toDos.length} ',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: toDos.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 240,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 300),
                              child: Column(
                                children: [
                                  Icon(Icons.delete),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SingleChildScrollView(
                                  child: Container(
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500/${movies[index].posterPath ?? ''}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Expanded(
                                  child: Text(
                                      'Firebase is an app development platform that helps you build and grow apps and games users love. Backed by Google and trusted by millions of businesses around the world.'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  updateButton() {
    return ElevatedButton(
      onPressed: () {
        updateItem(selectedIndex, _searchController.text);
        isUpdate = false;
        _searchController.clear();
      },
      child: const Text('Update'),
    );
  }

  Container textFormField() {
    return Container(
      height: 60,
      width: 270,
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _searchController,
        decoration: InputDecoration(
            hintText: 'Add a new item',
            filled: true,
            fillColor: Colors.purple.shade100.withOpacity(0.2),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
