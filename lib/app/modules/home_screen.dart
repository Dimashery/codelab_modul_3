import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';
import 'create_task_screen.dart';
import 'widget_background.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance; // Ubah Firestore ke FirebaseFirestore
  final AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;

    return Scaffold(
      key: scaffoldState,
      backgroundColor: appColor.colorPrimary,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WidgetBackground(),
            _buildWidgetListTodo(widthScreen, heightScreen, context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          bool result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateTaskScreen(isEdit: false)));
          if (result) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Task has been created'),
            ));
            setState(() {}); // Memperbarui tampilan jika task telah ditambahkan
          }
        },
        backgroundColor: appColor.colorTertiary,
      ),
    );
  }

  Container _buildWidgetListTodo(
      double widthScreen, double heightScreen, BuildContext context) {
    return Container(
      width: widthScreen,
      height: heightScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Todo List',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('tasks').orderBy('date').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> task = document.data() as Map<String, dynamic>;

                    DateTime? taskDate;

                    // Periksa tipe data 'date'
                    if (task['date'] is Timestamp) {
                      // Jika tipe data Timestamp, konversi menjadi DateTime
                      Timestamp timestamp = task['date'];
                      taskDate = timestamp.toDate();
                    } else if (task['date'] is String) {
                      // Jika tipe data String, parsing menjadi DateTime menggunakan parser kustom
                      taskDate = parseIndonesianDate(task['date']);
                    } else {
                      // Jika tipe data lain, gunakan tanggal sekarang sebagai fallback
                      taskDate = DateTime.now();
                    }

                    return Card(
                      child: ListTile(
                        title: Text(task['name']),
                        subtitle: Text(
                          task['description'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        isThreeLine: false,
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: appColor.colorSecondary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${taskDate?.day}', 
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${taskDate?.month}',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ];
                          },
                          onSelected: (String value) async {
                            if (value == 'edit') {
                              // TODO: Tambahkan fitur edit task
                            } else if (value == 'delete') {
                              await firestore.collection('tasks').doc(document.id).delete();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Task deleted successfully'),
                              ));
                              setState(() {});
                            }
                          },
                          child: Icon(Icons.more_vert),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi parser tanggal berbahasa Indonesia
  DateTime? parseIndonesianDate(String date) {
    Map<String, int> months = {
      'Januari': 1,
      'Februari': 2,
      'Maret': 3,
      'April': 4,
      'Mei': 5,
      'Juni': 6,
      'Juli': 7,
      'Agustus': 8,
      'September': 9,
      'Oktober': 10,
      'November': 11,
      'Desember': 12,
    };

    try {
      List<String> parts = date.split(' '); // Memisahkan tanggal, bulan, dan tahun
      int day = int.parse(parts[0]);
      int month = months[parts[1]]!;
      int year = int.parse(parts[2]);

      return DateTime(year, month, day);
    } catch (e) {
      print("Error parsing date: $e");
      return null;
    }
  }
}
