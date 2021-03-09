import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/centerDetaiils/page.dart';
import 'package:flutter_counter/home/cubit.dart';
import 'package:flutter_counter/home/representation.dart';
import 'package:flutter_counter/home/state.dart';
import 'package:flutter_counter/map/entity/ReserveStatus.dart';

enum AppBarActionMenu { SHOW_AVAILABLE_ONLY }

extension ParseToString on AppBarActionMenu {
  String toDisplayTitle() {
    switch (this) {
      case AppBarActionMenu.SHOW_AVAILABLE_ONLY:
        return "只顯示可預約";
      default:
        return "";
    }
  }
}

class HomeView extends StatelessWidget {
  HomeView();

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return DefaultTabController(
        length: state.allDates.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('AppBar Demo'),
            actions: [
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  Set<HomeMenuBottom> menuOptions = {};
                  if (state.showAvailableOnly) {
                    menuOptions.add(HomeMenuBottom.SHOW_AVAILABLE);
                  } else {
                    menuOptions.add(HomeMenuBottom.SHOW_ALL);
                  }
                  return menuOptions.map((HomeMenuBottom choice) {
                    if (choice == HomeMenuBottom.SHOW_AVAILABLE) {
                      return PopupMenuItem<String>(
                        value: "",
                        child: Row(
                          children: [
                            Text("只顯示尚有餘額"),
                            Checkbox(value: true, onChanged: (bool) {

                            }),
                          ],
                        ),
                      );
                    }
                    return PopupMenuItem<String>(
                      value: "not impl",
                      child: Text("not impl"),
                    );
                  }).toList();
                },
              ),
            ],
            bottom: TabBar(
              isScrollable: true,
              tabs: state.allDates.map((e) {
                return Tab(
                  child: Text('${e.day}/${e.month}'),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: state.allPages.map((e) => TabChildPage(e.regions)).toList(),
          ),
        ),
      );
    });
  }
}

class TabChildPage extends StatelessWidget {
  Set<RegionModel> regions;

  TabChildPage(this.regions){
    print("regions size: ${regions.length}");
  }

  @override
  Widget build(BuildContext context) {
    // fixme change to list
    return Container(
        width: double.infinity,
        child: ListView(children: regions.map((e) => RegionCard(e)).toList()));
  }
}

class RegionCard extends StatelessWidget {
  RegionModel region;

  RegionCard(this.region) {
    print("district size: ${region.districts.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        elevation: 2,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Column(
            children: [
              Text(
                region.name,
                style: TextStyle(fontSize: 28),
              ),
              Column(children: region.districts.map((e) => DistrictRow(e)).toList())
            ],
          ),
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
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: InkWell(
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              Text("地區：${district.name}"),
              Container(
                child: Column(
                  children: district.dateCenters.map((e) => CenterRow(e)).toList(),
                ),
              ),
            ],
          ),
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
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: InkWell(
        child: GestureDetector(
          onTap: () => goToCenterDetails(context, centerForDate.center),
          child: Card(
            child: SizedBox(
              height: 56.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Expanded(
                    child: ListTile(
                      title: Text(centerForDate.center.cName)
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
