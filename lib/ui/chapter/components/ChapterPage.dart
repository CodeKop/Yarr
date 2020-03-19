import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' show Html;
import 'package:flutter_html/style.dart';
import 'package:persist_theme/data/models/theme_model.dart';
import 'package:royalroad_api/models.dart' show AuthorNote, BookChapterContents;
import 'package:provider/provider.dart';

class ChapterPage extends StatelessWidget {
  final Future<BookChapterContents> chapterContentsFuture;

  ChapterPage(this.chapterContentsFuture);

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeModel>(context);
    return FutureBuilder<BookChapterContents>(
        future: chapterContentsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BackButton(),
                  Flexible(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 3, 15, 15),
                          child: Text(data.title,
                              style: TextStyle(
                                  color: _theme.darkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis))),
                  Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                      // useRichText fixes status screens, but is also ugly,
                      // just waiting on a fix from the library
                      child: Column(
                        children: <Widget>[
                          _htmlAuthorNote(data.note, theme: _theme),
                          Html(
                            data: data.contents,
                            useRichText: true,
                            defaultTextStyle: TextStyle(fontSize: 15),
                          ),
                        ],
                      ))
                ]);
          } else {
            // NOTE: This spinner will never time out
            return Container(
                height: MediaQuery.of(context).size.height,
                child: CupertinoActivityIndicator(radius: 15));
          }
        });
  }
}

_htmlAuthorNote(AuthorNote note, {theme}) {
  if (note == null) {
    return Container();
  } else {
    return Html(
      data: '<b>' +
          note.caption.toUpperCase() +
          '</b><br /><br />' +
          note.noteBody,
      style: {
        'html': Style(
            backgroundColor: theme.darkMode
                ? Color.fromRGBO(35, 35, 35, 1)
                : Color.fromRGBO(200, 200, 200, 1))
      },
    );
  }
}
