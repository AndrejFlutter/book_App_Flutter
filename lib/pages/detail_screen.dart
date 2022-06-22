import 'package:flutter/material.dart';
import 'package:kniha_test_app/models/book_model.dart';

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
        title: Text("Informacie o knihe"),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz_sharp, color: Colors.white))
            ],
            backgroundColor: Colors.transparent,
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 300.0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: '99',
                child: Image.network(widget.bookSelected.image),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 20, end: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRow(
                        Icons.title_sharp,
                        Colors.red,
                        'Title:',
                        widget.bookSelected.title,
                      ),
                      SizedBox(height: 20),
                      CustomRow(
                        Icons.join_inner,
                        Colors.green,
                        'Subtitle:',
                        widget.bookSelected.subtitle,
                      ),
                      SizedBox(height: 20),
                      CustomRow(
                        Icons.mail,
                        Colors.blue,
                        'Url:',
                        widget.bookSelected.url,
                      ),
                      SizedBox(height: 20),
                      CustomRow(
                        Icons.label,
                        Colors.purple,
                        'Price:',
                        widget.bookSelected.price,
                      ),
                      SizedBox(height: 20),
                      CustomRow(
                        Icons.location_city,
                        Colors.yellow,
                        'ISBN:',
                        widget.bookSelected.isbn13,
                      ),
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

  Widget CustomRow(
      IconData myIcon, Color myColor, String myText1, String myText2) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(myIcon, color: myColor),
        SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                myText1,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Flexible(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                myText2,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
