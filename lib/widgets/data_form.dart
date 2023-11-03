import 'package:flutter/material.dart';

class DataForm extends StatefulWidget {
  final Function(String) onSubmit;
  final String initialData;

  DataForm({required this.onSubmit, this.initialData = ''});

  @override
  _DataFormState createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  late TextEditingController _dataController;

  @override
  void initState() {
    super.initState();
    _dataController = TextEditingController(text: widget.initialData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _dataController,
          decoration: InputDecoration(labelText: 'Nuevo Dato'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit(_dataController.text);
            _dataController.clear();
          },
          child: Text('Agregar Dato'),
        ),
      ],
    );
  }
}
