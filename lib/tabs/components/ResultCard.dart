import 'package:flutter/material.dart';
import 'package:flutterroad/base/StatelessBookBase.dart';
import 'package:intl/intl.dart';
import 'package:persist_theme/data/models/theme_model.dart';
import 'package:royalroad_api/models.dart' show BookListResult;
import 'package:provider/provider.dart';

class ResultCard extends StatelessBookBase {
  final BookListResult book;
  final bool showBorder;

  ResultCard(this.book, {this.showBorder = true}) : super(book);

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Image column
          Column(
            children: <Widget>[
              getImage(MediaQuery.of(context).size.height / 6),
            ],
          ),
          // TODO: Look into this strat of dividing - feasible?
          SizedBox(width: MediaQuery.of(context).size.width / 50), // Padding
          // Details column 1
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Text(this.book.book.title,
                  style: TextStyle(
                      color: _theme.darkMode
                          ? Colors.brown.shade300
                          : Colors.brown,
                      fontSize: MediaQuery.of(context).size.height / 43),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 130), // Padding
              Text(this.book.info.genres.length <= 3
                  ? this.book.info.genres.join(", ")
                  : this.book.info.genres.sublist(0, 3).join(", ")),
              SizedBox(height: MediaQuery.of(context).size.height / 130),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // TODO: Use IconTheme if not doing multiple sizes later
                      Row(children: <Widget>[
                        Icon(Icons.people, size: 22),
                        Text(this.book.info.followers.toString() + " Followers")
                      ]),
                      Row(children: <Widget>[
                        Icon(Icons.book, size: 22),
                        Text(this.book.info.pages.toString() + " Pages")
                      ]),
                      Row(children: <Widget>[
                        Icon(Icons.list, size: 22),
                        Text(this.book.info.chapters.toString() + " Chapters")
                      ])
                    ],
                  ),
                  SizedBox(
                      width:
                          MediaQuery.of(context).size.height / 25), // Padding
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Icon(Icons.star, size: 22),
                        Text(this.book.info.rating.toString() + " Stars")
                      ]),
                      Row(children: <Widget>[
                        Icon(Icons.visibility, size: 22),
                        Text(NumberFormat.compact()
                                .format(this.book.info.views)
                                .toString() +
                            " Views")
                      ]),
                      Row(children: <Widget>[
                        Icon(Icons.calendar_today, size: 22),
                        Text(DateFormat('MMM, d y')
                            .format(this.book.info.lastUpdate)
                            .toString())
                      ]),
                    ],
                  )
                ],
              )
            ],
          ))
        ],
      ),
      decoration: this.showBorder
          ? BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color:
                          _theme.darkMode ? Colors.black26 : Colors.black12)))
          : BoxDecoration(),
    );
  }
}
