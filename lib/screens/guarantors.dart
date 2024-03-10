import 'package:flutter/material.dart';
import '../services/DBHelper.dart';
import 'add_guarantor.dart';
import 'assets/constants.dart'; // Import your database helper class
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

class GuarantorsPage extends StatefulWidget {
  final String username;

  const GuarantorsPage({super.key, required this.username});
  @override
  _GuarantorsPageState createState() => _GuarantorsPageState();
}

DatabaseHelper helper = DatabaseHelper.instance;

void initializeDatabaseFactory() {
  sqflite_ffi.databaseFactory = sqflite_ffi.databaseFactoryFfi;
}

class _GuarantorsPageState extends State<GuarantorsPage> {
  late String username;
  late List<Map<String, dynamic>> _kins = [];

  DatabaseHelper helper = DatabaseHelper.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    username = widget.username;
    helper.database;
    _loadKins();
  }

  Future<void> _loadKins() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    _kins = await dbHelper.getKins();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Guarantors', context),
          _buildBody(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddGuarantorPage()),
          )
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (_kins.isEmpty) {
      return Center(
        child: Text('No guarantors found.'),
      );
    } else {
      return DataTable(
        columns: [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('ID No')),
          DataColumn(label: Text('Contact')),
        ],
        rows: _kins.map((kin) {
          return DataRow(cells: [
            DataCell(Text(kin['id'].toString())),
            DataCell(Text(kin['name'])),
            DataCell(Text(kin['id_no'])),
            DataCell(Text(kin['contact'])),
          ]);
        }).toList(),
      );
    }
  }
}
