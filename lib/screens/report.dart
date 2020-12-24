import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/const.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/logindata.dart';
import 'package:ecommerce/model/query.dart';
import 'package:ecommerce/servies/store.dart';
import'package:ecommerce/screens/home.dart';
import 'package:ecommerce/model/languge.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class report extends StatefulWidget {
  static String id = "report";
  @override
  _reportState createState() => _reportState();
}

class _reportState extends State<report> {

  final _store = store();
  var data =[

  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // List<query> _query = ModalRoute.of(context).settings.arguments;
    final data = Provider.of<logindata>(context);
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, home.id);
            },
            icon: Icon(
              Icons.arrow_back,
              color: kMainColor,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
            stream: _store.loadquery(),
            builder: (context, snapshot) {
              final modelhud = Provider.of<provider>(context, listen: false);
              if (snapshot.hasData) {
                modelhud.changeisloading(false);
                // not save old values
                List<query> queries = [];
                for (var doc in snapshot.data.documents) {
                  var item = doc.data;
                  queries.add(query(
                      title: item[kQuerytitle],
                      des: item[kQuerydesc],
                      category: item[kQuerycategory],
                      score: item[kcategoryscore],
                      pid: doc.documentID));
                }
                var series =[
                  charts.Series<query, String>(
                  domainFn:(query _query,_)=>_query.category,
                    measureFn: (query _query,_)=>int.parse(_query.score),
                    id:'query',
                    data: queries,
                    colorFn: (_, __) =>
                    charts.MaterialPalette.green.shadeDefault,

                  )
                ];
                var chart =charts.BarChart(
                  series,vertical: false,
                  animate: true,
                  barRendererDecorator: new charts.BarLabelDecorator<String>(labelPosition: charts.BarLabelPosition.inside),
                  domainAxis:
                  new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),

                );

                return (
                  /*  ConstrainedBox(
                      constraints: BoxConstraints.expand(height: 20.0),
                      child: chart,
                    )*/
                     ListView
                       (
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Text(translator.translate('analysis'),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: kMainColor),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                            padding: EdgeInsets.only(right: 15.0),
                            width: MediaQuery.of(context).size.width - 30.0,
                            height: MediaQuery.of(context).size.height - 50.0,
                            child: ListView.builder(
                                itemBuilder: (context, index) => Container(
                                  padding: EdgeInsets.only(
                                      top: 5, right: 10, left: 10),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: kMainColor, width: 0.5),
                                        borderRadius:
                                        BorderRadius.circular(50)),
                                    child: ListTile(
                                      title: Text(queries[index].title),
                                      trailing: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        child: Text(
                                          queries[index].score+"%",
                                          style:
                                          TextStyle(color: Colors.white),
                                        ),
                                        color: kMainColor,
                                      ),
                                    ),
                                  ),
                                ),
                                itemCount: queries.length)),
                        SizedBox(height: 15.0),
                      ],
                    )
                );
              } else {
                return Center(
                  child: Text("loading.........."),
                );
              }
            }));
  }
}
