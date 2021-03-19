import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "最新疫苗資訊",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "衞生防護中心熱線電話： 2125 1111 / 2125 1122 (上午九時至晚上八時運作)",
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  "民政事務總署熱線電話： 2835 1473 (星期一至五上午九時至下午六時運作)",
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  "「香港特別行政區政府COVID-19」 WhatsApp熱線： 9617 1823",
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text("2019 冠狀病毒病個案的最新情況 "),
            onTap: () {
              launch("https://www.chp.gov.hk/files/pdf/local_situation_covid19_tc.pdf");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text("14天內曾有確診或疑似個案居住過的住宅大廈名單"),
            onTap: () {
              launch("https://www.chp.gov.hk/files/pdf/building_list_chi.pdf");
            },
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text("指定檢疫酒店名單(由2021年4月21日至6月19日)"),
            onTap: () {
              launch("https://gia.info.gov.hk/general/202103/19/P2021031900533_363191_1_1616140834506.pdf");
            },
          )
        ],
      )
    );
  }
}
