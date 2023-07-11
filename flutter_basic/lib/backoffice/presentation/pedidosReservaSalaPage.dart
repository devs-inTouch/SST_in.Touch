import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/application/salasRequestAuth.dart';
import 'package:flutter_basic/backoffice/presentation/responsive_backOffice.dart';
import '../../constants.dart';
import '../../myAppBar.dart';
import 'backOfficePage.dart';
import '../boxes/bookingBox.dart';

class PedidoReservaSalaPage extends StatefulWidget {
  const PedidoReservaSalaPage({super.key});

  State<PedidoReservaSalaPage> createState() => ReservasState();
}

class ReservasState extends State<PedidoReservaSalaPage> {
  List requestsList = [];

  void initState() {
    super.initState();
    fetchSalas();
  }

  void fetchSalas() async {
    final response = await SalasRequestAuth.getBookingList();
    setState(() {
      requestsList = response;
    });
    print("requests fetched");
    print(requestsList);
    if (requestsList.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sem requests"),
            content: Text("No requests available."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResponsiveBackOffice()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackground,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "PEDIDOS E RESERVAS DE SALAS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResponsiveBackOffice()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "SALA:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: 800,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: requestsList.length,
                itemBuilder: (BuildContext context, int index) {
                  BookingBox bookingBox = requestsList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: BookingBox(
                      username: bookingBox.username,
                      room: bookingBox.room,
                      department: bookingBox.department,
                      numberStudents: bookingBox.numberStudents,
                      date: bookingBox.date,
                      hour: bookingBox.hour,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
