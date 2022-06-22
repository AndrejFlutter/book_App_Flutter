import 'package:flutter/material.dart';
import 'package:kniha_test_app/models/book_model.dart';
import 'package:kniha_test_app/widget/custom_row.dart';

class DetailScreen extends StatefulWidget {
  BookElement bookSelected;
  DetailScreen({Key? key, required this.bookSelected}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.bookSelected.title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_sharp, color: Colors.white))
            ],
            backgroundColor: Colors.transparent,
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 390.0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(
                    widget.bookSelected.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomRow(
                        Icons.title_sharp,
                        Colors.red,
                        'Title:',
                        widget.bookSelected.title,
                      ),
                      const SizedBox(height: 20),
                      CustomRow(
                        Icons.join_inner,
                        Colors.green,
                        'Subtitle:',
                        widget.bookSelected.subtitle,
                      ),
                      const SizedBox(height: 20),
                      CustomRow(
                        Icons.label,
                        Colors.purple,
                        'Price:',
                        widget.bookSelected.price,
                      ),
                      const SizedBox(height: 20),
                      CustomRow(
                        Icons.location_city,
                        Colors.yellow,
                        'ISBN:',
                        widget.bookSelected.isbn13,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Order Book',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Close',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
