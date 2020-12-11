import 'package:flutter/material.dart';
import 'package:fluttertestapp/provider/MainProvider.dart';
import 'package:fluttertestapp/utils/ColorUtils.dart';
import 'package:fluttertestapp/utils/Constants.dart';
import 'package:fluttertestapp/utils/StringUtils.dart';
import 'package:provider/provider.dart';

import 'BasePageScreen.dart';

class MainListScreen extends BasePageScreen {
  @override
  _MainListScreen createState() => _MainListScreen();
}

class _MainListScreen extends BasePageScreenState<MainListScreen>
    with BaseScreen {
  final _searchController = TextEditingController();
  final _formSearch = GlobalKey<FormState>();

  MainProvider mainProvider;


  bool adsf = false;

  @override
  String appBarTitleText() {
    return "";
  }

  @override
  dynamic appBarTitleColor() {
    return ColorUtils.c_e6e6e6;
  }

 @override
  void setIsSetting(isSetting) {
    super.setIsSetting(isSetting);
  }

  @override
  void initState() {
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    setIsSetting(true);
    getEmployeeList();
    super.initState();
  }

  @override
  Widget body() {
    return Scaffold(
      body: Form(
        key: _formSearch,
        child: Container(
            color: ColorUtils.c_e6e6e6,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListView(children: <Widget>[
              _searchEdit(),
//              Expanded(child: Container())
            ])),
      ),
    );
  }

  Widget _searchEdit() {
    return Stack(alignment: const Alignment(1.0, 0), children: <Widget>[
      Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: StringUtils.mainlistSearch,
            hintText: StringUtils.mainlistSearchHint,
            prefixIcon: Padding(
              padding: EdgeInsets.all(0.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ), // icon is 48px widget.
            ),
//                suffixIcon: IconButton(
//                  onPressed: () => _searchController.clear(),
//                  icon: Icon(Icons.clear),
//                ),
          ),
//
          onChanged: (value) {
            setState(() {});
            // todo
          },
        ),
      ),
      _searchController.text.length > 0
          ? IconButton(
              icon: Icon(Icons.clear),
              iconSize: 20,
              onPressed: () {
                setState(() {
                  _searchController.clear();
                });
              })
          : Container()
    ]);
  }


  /// 직원리스트가져오기
  getEmployeeList() async{
    setState(() => isLoading = true);

    Map dataMap = {
      'methodid': Constants.JW3001,
      'year': '2020'
    };

    final reqData = await mainProvider.jw3001(dataMap);

    setState(() => isLoading = false);

    if (reqData == null) {
      showNetworkErrorDialog();
      return;
    }
  }
}
