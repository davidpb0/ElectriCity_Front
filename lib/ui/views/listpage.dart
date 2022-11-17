import 'package:electricity_front/ui/components/list_item_component.dart';
import 'package:flutter/material.dart';

import '../../core/controllers/list_controller.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
        ),
        body: Body());
  }
}

class Body extends StatelessWidget {
  ListController listCtrl = ListController();

  @override
  Widget build(BuildContext context) {
    //Da la altura y el ancho total de la pantalla
    Size size = MediaQuery.of(context).size;
    listCtrl.getstations();
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text("ElectriCity"),
        ),
        body: ListView.builder(
          itemCount: listCtrl.getTotalStations(),
          itemBuilder: (context, index) {
            return ListItemComponent(info: listCtrl.getStation(index));
          },
        ));
  }
}
