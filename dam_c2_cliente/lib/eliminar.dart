import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Eliminar extends StatefulWidget {
  //Eliminar({Key? key}) : super(key: key);

  @override
  State<Eliminar> createState() => _Eliminar();
}

class _Eliminar extends State<Eliminar> {
  TextEditingController vinController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('eliminar el Auto'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Ingrese Vin del Auto'),
            controller: vinController,
          ),
          ElevatedButton(
              onPressed: () {
                deleteAuto(vinController);
              },
              child: Text('Eliminado'))
        ],
      ),
    );
  }

  void deleteAuto(dynamic id) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/dam_c2_api/${vinController}');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      print('auto borrado');
    } else {}
  }
}