import 'package:flutter/material.dart';
import 'package:persist_theme/data/models/theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class DialogContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  var _fontSize = 15; // In testing this has been OK to set. Otherwise,
  // get a toDouble() error if the dialog loads too fast
  SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSharedPreferences();
    });
  }

  _loadSharedPreferences() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    setState(() {
      _fontSize = _prefs.getInt('chapterFontSize');
    });
  }

  _buildDialog(context) {
    return Column(children: <Widget>[
      Text("Display settings", style: TextStyle(fontSize: 18)),
      Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 25), // this will need adjusting
              child: Text("Text size", style: TextStyle(fontSize: 16)))
        ],
      ),
      _buildTextSizeSlider(context)
    ]);
  }

  _buildTextSizeSlider(context) => SliderTheme(
      data: SliderTheme.of(context).copyWith(
        tickMarkShape: RoundSliderTickMarkShape(),
        inactiveTickMarkColor: Provider.of<ThemeModel>(context).darkMode
            ? Colors.red[100]
            : Colors.red[400],
      ),
      child: Slider(
        min: 10,
        max: 30,
        value: _fontSize.toDouble(),
        divisions: 6,
        label: '$_fontSize',
        onChanged: (value) {
          setState(() {
            _fontSize = value.toInt();
            _prefs.setInt('chapterFontSize', value.toInt());
          });
        },
      ));

  _buildFontOption(context)

  @override
  Widget build(BuildContext context) {
    return _buildDialog(context);
  }
}
