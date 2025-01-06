import 'package:flutter/material.dart';
import '../models/San.dart';
import '../services/phieu_dat_san_service.dart';

class DatSanPage extends StatefulWidget {
  @override
  _DatSanPageState createState() => _DatSanPageState();
}

class _DatSanPageState extends State<DatSanPage> {
  List<San> _sans = [];
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadSans();
  }

  void _loadSans() async {
    final api = PhieuDatSanApi();
    final sans = await api.getSans(_selectedDate);
    setState(() {
      _sans = sans;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đặt Sân Cầu Lông')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              ).then((selectedDate) {
                if (selectedDate != null && selectedDate != _selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                    _loadSans();
                  });
                }
              });
            },
            child: Text('Chọn Ngày: ${_selectedDate.toLocal()}'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _sans.length,
              itemBuilder: (context, index) {
                final san = _sans[index];
                return ListTile(
                  title: Text(san.name),
                  tileColor: san.isBooked ? Colors.red : Colors.green,
                  onTap: san.isBooked ? null : () {
                    // Xử lý đặt sân
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
