import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Tabs/add_pages.dart';
import '../providers/providers.dart';

class Agregar extends StatefulWidget {
  //Agregar({Key? key}) : super(key: key);

  @override
  State<Agregar> createState() => _Agregar();
}

class _Agregar extends State<Agregar> {
  TextEditingController vinController = new TextEditingController();
  TextEditingController marcaController = new TextEditingController();
  TextEditingController modeloController = new TextEditingController();
  TextEditingController anioController = new TextEditingController();
  TextEditingController precioController = new TextEditingController();

  late Auto _auto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar nuevo auto'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Ingrese Vin del auto'),
                controller: vinController,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese marca'),
                controller: marcaController,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese modelo'),
                keyboardType: TextInputType.number,
                controller: modeloController,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese año'),
                controller: anioController,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese precio'),
                controller: precioController,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String vin = vinController.text;
                    String marca = marcaController.text;
                    String modelo = modeloController.text;
                    int anio = anioController.value as int;
                    int precio = precioController.value as int;
                    Auto? autos =
                        await submitData(vin, marca, modelo, anio, precio);

                    setState(() {
                      _auto = autos!;
                    });
                  },
                  child: Text('Auto'))
            ],
          ),
        ),
      ),
    );
  }

  Future<Auto?> submitData(
      String vin, String marca, String modelo, int anio, int precio) async {
    const apiURL = 'http://10.0.2.2:8000/api/dam_c2_api';

    var url = Uri.parse(apiURL);
    var response = await http.post((url), body: {
      'vin': vin,
      'marca': marca,
      'modelo': modelo,
      'año': anio,
      'precio': precio
    });
    var data = response.body;
    print(data);

    if (response.statusCode == 200) {
      String responseString = response.body;
      autoFromJson(responseString);
    } else {
      return null;
    }
  }
}