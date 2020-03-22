import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' show Html;
import 'package:flutter_html/style.dart';
import 'package:flutterroad/service_locator.dart';
import 'package:flutterroad/services/localstorge_service.dart';
import 'package:flutterroad/ui/chapter/components/DialogContent.dart';
import 'package:persist_theme/data/models/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:royalroad_api/models.dart' show AuthorNote, BookChapterContents;
import 'package:slide_popup_dialog/slide_popup_dialog.dart';

class ChapterPage extends StatefulWidget {
  final Future<BookChapterContents> chapterContentsFuture;
  ChapterPage(this.chapterContentsFuture);

  @override
  State<StatefulWidget> createState() =>
      _ChapterPageState(this.chapterContentsFuture);
}

class _ChapterPageState extends State<ChapterPage> {
  final Future<BookChapterContents> chapterContentsFuture;
  _ChapterPageState(this.chapterContentsFuture);

  int _fontSize;
  int _fontSizeTitle;
  LocalStorageService _prefs;
  String _fontFamily;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  _loadSharedPreferences() async {
    _prefs = getIt.get<LocalStorageService>();

    if (_prefs.containsKey('chapterFontSize')) {
      setState(() {
        _fontSize = _prefs.fontSize;
        _fontSizeTitle = _prefs.fontSize + 5;
      });
    } else {
      _prefs.fontSize = 16;
      setState(() {
        _fontSize = 16;
        _fontSizeTitle = 16 + 5;
      });
    }

    if (_prefs.containsKey('chapterFontFamily')) {
      _fontFamily = _prefs.fontFamily;
    } else {
      _prefs.fontFamily = 'Lora';
      setState(() {
        _fontFamily = 'Lora';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeModel>(context);
    return FutureBuilder<BookChapterContents>(
        future: chapterContentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return _buildError();
            }
            if (snapshot.hasData) {
              final data = snapshot.data;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    BackButton(),
                    _buildTitle(data.title, theme: _theme),
                    GestureDetector(
                        onTap: () => _showDialog()
                            .then((value) => _loadSharedPreferences()),
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, bottom: 5),
                            // useRichText fixes status screens, but is also ugly,
                            // just waiting on a fix from the library
                            child: Column(
                              children: <Widget>[
                                if (data.note != null)
                                  _htmlAuthorNote(data.note, theme: _theme),
                                Html(
                                  data: data.contents,
                                  useRichText: true,
                                  defaultTextStyle: TextStyle(
                                      fontSize: _fontSize.toDouble(),
                                      fontFamily: _fontFamily),
                                ),
                              ],
                            )))
                  ]);
            } else {
              return _buildLoader();
            }
          } else {
            return _buildLoader();
          }
        });
  }

  Future _showDialog() =>
      showSlideDialog(context: context, child: DialogContent());

  _buildTitle(title, {theme}) => Flexible(
      child: Padding(
          padding: EdgeInsets.fromLTRB(15, 3, 15, 15),
          child: Text(title,
              style: TextStyle(
                  // color is to make title slighty darker than the text in light mode
                  color: theme.darkMode ? Colors.white : Colors.black,
                  fontSize: _fontSizeTitle.toDouble(),
                  fontFamily: _fontFamily),
              maxLines: 3,
              overflow: TextOverflow.ellipsis)));

  _buildLoader() => Container(
      height: MediaQuery.of(context).size.height,
      child: CupertinoActivityIndicator(radius: 15));

  _buildError() => Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
          child:
              Text("Could not load chapter", style: TextStyle(fontSize: 15))));

  /// Returns HTML display of the author note assuming one is present
  _htmlAuthorNote(AuthorNote note, {theme}) => Html(
        data: '<b>' +
            note?.caption?.toUpperCase() +
            '</b><br /><br />' +
            note?.noteBody,
        style: {
          'html': Style(
              backgroundColor: theme.darkMode
                  ? Color.fromRGBO(35, 35, 35, 1)
                  : Color.fromRGBO(200, 200, 200, 1))
        },
      );
}
