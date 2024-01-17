
import 'package:flutter/material.dart';

class PayUtilitiesPage extends StatefulWidget {
  @override
  State<PayUtilitiesPage> createState() => _PayUtilitiesPageState();
}

class _PayUtilitiesPageState extends State<PayUtilitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Utilities Page'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF003366), Color(0xFF005599)],
            ),
          ),
        ),
      ),
      body: _buildGridView(),
    );
  }

  Widget _buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.all(16.0),
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: [
        _buildUtilityItem('DSTv', Icons.tv),
        _buildUtilityItem('GoTv', Icons.tv),
        _buildUtilityItem('StarTimes', Icons.tv),
        _buildUtilityItem('KPLC', Icons.flash_on),
        _buildUtilityItem('NHIF', Icons.local_hospital),
        _buildUtilityItem('Till', Icons.payment),
      ],
    );
  }

  Widget _buildUtilityItem(String name, IconData icon) {
    return InkWell(
      onTap: () {
        // Handle utility item click
        print('Clicked on $name');
      },
      child: Card(
        elevation: 3.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48.0,
              color: Colors.blue,
            ),
            SizedBox(height: 8.0),
            Text(
              name,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}