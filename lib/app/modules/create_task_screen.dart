import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_color.dart';
import 'widget_background.dart';

class CreateTaskScreen extends StatefulWidget {
  final bool isEdit;
  final String documentId;
  final String name;
  final String description;
  final String date;

  CreateTaskScreen({
    required this.isEdit,
    this.documentId = '',
    this.name = '',
    this.description = '',
    this.date = '',
  });

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AppColor appColor = AppColor();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final TextEditingController controllerDate = TextEditingController();

  late DateTime date;
  bool isLoading = false;

  @override
  void initState() {
    if (widget.isEdit) {
      date = DateFormat('dd MMMM yyyy').parse(widget.date);
      controllerName.text = widget.name;
      controllerDescription.text = widget.description;
      controllerDate.text = widget.date;
    } else {
      date = DateTime.now().add(Duration(days: 1));
      controllerDate.text = DateFormat('dd MMMM yyyy').format(date);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.colorPrimary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WidgetBackground(),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    widget.isEdit ? 'Edit\nTask' : 'Create\nNew Task',
                    style: Theme.of(context).textTheme.headlineMedium?.merge(
                          TextStyle(color: Colors.grey[800]),
                        ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: controllerName,
                    decoration: InputDecoration(labelText: 'Name'),
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: controllerDescription,
                    decoration: InputDecoration(labelText: 'Description'),
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: controllerDate,
                    decoration: InputDecoration(labelText: 'Date'),
                    style: TextStyle(fontSize: 18.0),
                    readOnly: true,
                    onTap: () async {
                      DateTime? datePicker = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025),
                      );
                      if (datePicker != null) {
                        setState(() {
                          date = datePicker;
                          controllerDate.text = DateFormat('dd MMMM yyyy').format(date);
                        });
                      }
                    },
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      String name = controllerName.text;
                      String description = controllerDescription.text;

                      if (name.isEmpty || description.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Name and Description are required')),
                        );
                        return;
                      }

                      setState(() => isLoading = true);

                      if (widget.isEdit) {
                        DocumentReference taskRef = firestore.collection('tasks').doc(widget.documentId);
                        await taskRef.update({
                          'name': name,
                          'description': description,
                          'date': Timestamp.fromDate(date), // Simpan sebagai Timestamp
                        });
                      } else {
                        CollectionReference tasks = firestore.collection('tasks');
                        await tasks.add({
                          'name': name,
                          'description': description,
                          'date': Timestamp.fromDate(date), // Simpan sebagai Timestamp
                        });
                      }

                      setState(() => isLoading = false);
                      Navigator.pop(context, true);
                    },
                    child: Text(widget.isEdit ? 'Update Task' : 'Create Task'),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
