import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../constants.dart';
import '../model/event.dart';
import '../provider/event_provider.dart';
import '../utils.dart';
import 'package:provider/provider.dart';

class EventEditingPage extends StatefulWidget {
  final DateTime fromDate;
  final Event? event;

  const EventEditingPage({
    Key? key,
    this.event,
    required this.fromDate,
  }) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final tittleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  late Color color;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      final dateNow = DateTime.now();
      fromDate = DateTime(widget.fromDate.year, widget.fromDate.month,
          widget.fromDate.day, dateNow.hour, dateNow.minute);
      toDate = fromDate.add(const Duration(hours: 2));
      color = Colors.blue;
    } else {
      final event = widget.event!;
      tittleController.text = event.title;
      fromDate = event.from;
      toDate = event.to;
      color = event.backgroundColor;
    }
  }

  @override
  void dispose() {
    tittleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildEditingActions(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(),
                SizedBox(height: 12),
                buildDateTimePickers(),
                SizedBox(height: 12),
                buildColorPicker(),
                SizedBox(height: 12),
                buildDescription(),
              ],
            ),
          ),
        ),
      );

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          onPressed: saveFrom,
          icon: const Icon(Icons.done),
          label: const Text('SAVE'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
        ),
      ];

  Widget buildColorPicker() => buildHeader(
        header: 'Color',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              width: 20,
              height: 20,
              alignment: Alignment.bottomRight,
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                alignment: AlignmentDirectional.center,
                backgroundColor: primarySwatch,
                padding: const EdgeInsets.all(12),
              ),
              child: const Text('Escolher cor'),
              onPressed: () => pickColor(context),
            )
          ],
        ),
      );

  void pickColor(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Escolha uma cor"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              selectColor(context),
              TextButton(
                child: const Text("Escolher cor",
                    style: TextStyle(
                      fontSize: 18,
                    )),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      );

  Widget selectColor(BuildContext context) => BlockPicker(
        pickerColor: color,
        availableColors: const [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.indigo,
          Colors.purple,
          Colors.pink,
          Colors.brown,
          Colors.grey,
          Colors.black,
          Colors.teal,
          Colors.cyan,
          Colors.lime,
          Colors.amber,
          Colors.deepOrange,
        ],
        onColorChanged: (pickedColor) => setState(() => color = pickedColor),
      );

  Widget buildDescription() => buildHeader(
        header: 'Description',
        child: TextFormField(
            style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Add Description',
            ),
            maxLines: 5,
            onFieldSubmitted: (_) => saveFrom(),
            controller: descriptionController),
      );

  Widget buildTitle() => TextFormField(
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add Title',
        ),
        onFieldSubmitted: (_) => saveFrom(),
        validator: (title) =>
            title != null && title.isEmpty ? 'Title cannot be empty' : null,
        controller: tittleController,
      );

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildFrom() => buildHeader(
        header: 'FROM',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropDownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropDownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );
  Widget buildTo() => buildHeader(
        header: 'To',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropDownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropDownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );
  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);

    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() {
      fromDate = date;
    });
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);

    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() {
      toDate = date;
    });
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2021, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time = Duration(
        hours: initialDate.hour,
        minutes: initialDate.minute,
      );

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date = DateTime(
        initialDate.year,
        initialDate.month,
        initialDate.day,
      );

      final time = Duration(
        hours: timeOfDay.hour,
        minutes: timeOfDay.minute,
      );

      return date.add(time);
    }
  }

  Widget buildDropDownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child,
        ],
      );

  Future saveFrom() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final event = Event(
        title: tittleController.text,
        description: descriptionController.text,
        from: fromDate,
        to: toDate,
        isAllDay: false,
        backgroundColor: color,
      );
      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, widget.event!);
      } else {
        provider.addEvent(event);
      }
      Navigator.of(context).pop();
    }
  }
}
