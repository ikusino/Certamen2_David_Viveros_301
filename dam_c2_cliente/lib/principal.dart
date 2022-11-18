import 'package:dam_c2_cliente/Agregar.dart';
import 'package:dam_c2_cliente/eliminar.dart';
import 'package:dam_c2_cliente/listar.dart';
import 'package:flutter/material.dart';


class principal extends StatefulWidget {
  //const principal({super.key});

  @override
  State<principal> createState() => _principalState();
}

class _principalState extends State<principal> {
  @override

  int _currentIndex = 0;
  List<Widget> _pages = [
    
    AutoList(),
    Agregar(),
    Eliminar(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.houseboat_outlined), label: 'Listar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplanemode_active), label: 'Agregar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.call_end_sharp), label: 'Eliminar'),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          //print(index); para ver en consola que funciona
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}