import 'package:admob_flutter/admob_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_hk/app/cubit.dart';
import 'package:vaccine_hk/app/state.dart';
import 'package:vaccine_hk/centerDetails/page.dart';
import 'package:vaccine_hk/extensions.dart';
import 'package:vaccine_hk/home/cubit.dart';
import 'package:vaccine_hk/home/state.dart';
import 'package:vaccine_hk/home/viewModel.dart';
import 'package:vaccine_hk/map/entity/ReserveStatus.dart';
import 'package:vaccine_hk/map/view/map_view.dart';
import 'package:vaccine_hk/stringRes.dart';

class HomeView extends StatelessWidget {
  HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, appState) {
      return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        Fluttertoast.showToast(
            msg: "已切換至${state.selectedVaccine!.vaccine}疫苗",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.teal[600],
            textColor: Colors.white,
            fontSize: 16.0);

        if (state.version > 0) {
          print("version: ${state.version}");
          return DefaultTabController(
            length: state.allDates.length,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('安心打疫苗'),
                actions: [
                  // appState.currentTheme == ThemeMode.light
                  //     ? IconButton(
                  //         icon: Icon(Icons.nights_stay_rounded),
                  //         onPressed: () {
                  //           context.read<AppCubit>().changeTheme(ThemeMode.dark);
                  //         })
                  //     : IconButton(
                  //         icon: Icon(Icons.wb_sunny_rounded),
                  //         onPressed: () {
                  //           context.read<AppCubit>().changeTheme(ThemeMode.light);
                  //         }),
                  IconButton(
                      icon: Icon(Icons.merge_type),
                      onPressed: () {
                        context.read<HomeCubit>().switchVaccine();
                      }),
                  IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        context.read<HomeCubit>().refreshPage();
                      }),
                  IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        List<String> subscribedCenters = prefs.getStringList("centerNames") ?? [];
                        await showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text(subscribedCenters.isEmpty
                                    ? "你目前沒有已訂閱的疫苗中心"
                                    : "已訂閱${subscribedCenters.length}個疫苗中心"),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: subscribedCenters.map((e) {
                                      return Text(e.urlDecode());
                                    }).toList(),
                                  ),
                                ),
                                actions: subscribedCenters.isEmpty
                                    ? [
                                        TextButton(
                                          child: Text('確認'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ]
                                    : [
                                        TextButton(
                                          child: Text('清除全部'),
                                          onPressed: () async {
                                            // await FirebaseMessaging.instance.deleteToken();
                                            SharedPreferences prefs =
                                                await SharedPreferences.getInstance();
                                            prefs.remove("centerNames");
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('確認'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ]);
                          },
                        );
                      }),
                ],
                bottom: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Colors.white, width: 4.0),
                  ),
                  isScrollable: true,
                  tabs: state.allDates.map((e) {
                    return Tab(
                      child: Column(
                        children: [
                          Text(e.toHumanFriendly(), style: TextStyle(fontSize: 15)),
                          Text(e.toWeekDay(), style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: state.allPages
                    .map((e) => TabChildPage(state.selectedVaccine!.vaccine, e.regions))
                    .toList(),
              ),
              bottomNavigationBar: Container(
                child: AdmobBanner(
                  adUnitId: AdUnits.HOME_BOTTOM_BANNER,
                  adSize: AdmobBannerSize.BANNER,
                ),
              ),
            ),
          );
        } else {
          throw Exception();
        }
      });
    });
  }
}

class TabChildPage extends StatelessWidget {
  Set<RegionModel> regions;
  String currentVaccine;

  TabChildPage(this.currentVaccine, this.regions){
    print("regions size: ${regions.length}");
  }

  @override
  Widget build(BuildContext context) {
    String lastUpdateAtDisplay = DateFormat("dd-MM-yyyy hh:mm:ss a").format(DateTime.now());
    Map<int, Widget> prependItems = Map.fromEntries([
      MapEntry(
          0,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("你可以從下面的地圖中，尋找最近你的診所或醫院，並預約接受疫苗注射；\n亦可以從下面列表點擊進入詳細頁。",
                style: TextStyle(color: Colors.grey[600])),
          )),
      MapEntry(
          1,
          SizedBox(
            height: 250,
            child: MapView(),
          )),
      MapEntry(
          2,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("最後更新: $lastUpdateAtDisplay", style: TextStyle(color: Colors.grey[600])),
          )),
      MapEntry(
          3,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("目前顯示疫苗種類: $currentVaccine", style: TextStyle(color: Colors.grey[600])),
          )),
    ]);
    return new ListView.builder(
      itemCount: regions.length + prependItems.length,
      itemBuilder: (BuildContext context, int index) {
        bool shouldShowExtraItem = prependItems.entries.any((element) => element.key == index);
        if (shouldShowExtraItem) {
          return prependItems.entries.toList()[index].value;
        } else {
          return RegionCell(regions.elementAt(index - prependItems.length));
        }
      },
    );
  }
}

class RegionCell extends StatelessWidget {
  RegionModel region;

  RegionCell(this.region) {
    print("district size: ${region.districts.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "地區：${region.name}",
                style: TextStyle(fontSize: 28),
              ),
            ),
            Column(children: region.districts.map((e) => DistrictRow(e)).toList())
          ],
        ),
      ),
    );
  }
}

class DistrictRow extends StatelessWidget {
  DistrictModel district;

  DistrictRow(this.district);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "分區：${district.name}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Column(
              children: district.dateCenters.map((e) => CenterRow(e)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CenterRow extends StatelessWidget {
  CenterForDateModel centerForDate;

  CenterRow(this.centerForDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: GestureDetector(
          onTap: () => goToCenterDetails(context, centerForDate.center),
          child: Card(
            elevation: 4,
            child: SizedBox(
              height: 56.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: AutoSizeText(centerForDate.center.cName,
                              style: TextStyle(fontSize: 18),
                              minFontSize: 16,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    color: centerForDate.status.toColor(),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: new Text(
                      centerForDate.status.toName(),
                      style: new TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  goToCenterDetails(BuildContext context, CenterModel center) {
    print(center.toJson());
    Navigator.pushNamed(
      context,
      CenterDetailsPage.routeName,
      arguments: CenterDetailsPageArguments(cName: center.cName),
    );
  }
}
