import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/reservaSalas/application/reservaRequest.dart';
import 'package:flutter_basic/reservaSalas/presentation/salasBox.dart';

class SalasDisponiveisPage extends StatefulWidget {
  const SalasDisponiveisPage({Key? key}) : super(key: key);

  @override
  SalasDisponiveisState createState() => SalasDisponiveisState();
}

class SalasDisponiveisState extends State<SalasDisponiveisPage> {
  List salasDisponiveis = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  void fetchNotifications() async {
    // Define the date and hour variables or use the correct values
    final date = 'your_date';
    final hour = 'your_hour';

    final response = await ReservaAuth.getRoomsList(date, hour);
    setState(() {
      salasDisponiveis = response;
    });
    print("Notifications fetched");
    print(salasDisponiveis);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: salasDisponiveis.length,
            itemBuilder: (BuildContext context, int index) {
              final sala = salasDisponiveis[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200], // Light grey for tiles
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  padding: EdgeInsets.all(10.0),
                  child: SalasBox(
                    name: sala.message,
                    department: sala.department,
                    space: sala.space,
                    date: sala.date,
                    hour: sala.hour,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
