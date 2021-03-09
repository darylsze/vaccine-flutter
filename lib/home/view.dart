import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/home/cubit.dart';
import 'package:flutter_counter/home/representation.dart';
import 'package:flutter_counter/home/state.dart';
import 'package:flutter_counter/map/entity/ReserveStatus.dart';

class HomeView extends StatelessWidget {
  HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return DefaultTabController(
        length: state.allDates.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('AppBar Demo'),
            actions: [],
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

  TabChildPage(this.regions);

  @override
  Widget build(BuildContext context) {
    // fixme change to list
    return Container(
        width: double.infinity,
        child: Column(children: regions.map((e) => RegionCard(e)).toList()));
  }
}

class RegionCard extends StatelessWidget {
  RegionModel region;

  RegionCard(this.region);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class DistrictRow extends StatelessWidget {
  DistrictModel district;

  DistrictRow(this.district);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: district.centers.map((e) => CenterRow(e)).toList(),
    );
  }
}

class CenterRow extends StatelessWidget {
  CenterModel center;

  CenterRow(this.center);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: new InkWell(
        child: new Card(
          child: new SizedBox(
            height: 56.0,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Expanded(
                  child: new ListTile(
                    title: new Text("center name"),
                  ),
                ),
                new Container(
                  color: center.status.toColor(),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: new Text(
                    center.status.toName(),
                    style: new TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
