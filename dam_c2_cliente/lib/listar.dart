import 'package:dam_c2_cliente/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/providers.dart';

class AutoList extends StatefulWidget {
  //const AutoList({super.key});

  @override
  State<AutoList> createState() => _AutoList();
}

class _AutoList extends State<AutoList> {
  var fPrecio =
      NumberFormat.currency(decimalDigits: 0, locale: 'es-CL', symbol: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de autos disponibles'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: AutosProvider().getAutos(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                separatorBuilder: (_, __) => Divider(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var Auto = snapshot.data[index];
                  return ListTile(
                    leading: Icon(Icons.car_rental_sharp),
                    title: Text(snapshot.data[index]['marca']),
                    subtitle: Text(Auto['model'] +
                        " Año " +
                        '${snapshot.data[index]['año']}'),
                    trailing: Chip(
                      label:
                          Text('\$ ${fPrecio.format(Auto['precio'])}'),
                    ),
                  );
                },
              );
            },
          )),
        ],
      ),
    );
  }
}