import 'package:flutter/material.dart';
import 'package:reales_actividad3/widgets/data_form.dart';
import 'package:reales_actividad3/services/data_service.dart';
import 'package:reales_actividad3/services/auth_service.dart';
import 'package:reales_actividad3/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataService _dataService = DataService();
  final AuthService _authService = AuthService();

  List<String> _dataList = [];
  int _selectedItemIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadDataList();
  }

  void _loadDataList() async {
    final dataList = await _dataService.getDataList();
    setState(() {
      _dataList = dataList;
    });
  }

  void _addData(String newData) async {
    await _dataService.addData(newData);
    _loadDataList();
  }

  void _editData(int index, String updatedData) async {
    await _dataService.editData(index, updatedData);
    _loadDataList();
  }

  void _deleteData(int index) async {
    await _dataService.deleteData(index);
    _loadDataList();
  }

  void _showAddDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Dato', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DataForm(
                onSubmit: (newData) {
                  _addData(newData);
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Cancelar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditDataDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Dato', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          content: DataForm(
            initialData: _dataList[index],
            onSubmit: (updatedData) {
              _editData(index, updatedData);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void _showDeleteDataDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar Dato', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          content: Text('¿Seguro que deseas eliminar este dato?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar', style: TextStyle(fontSize: 18, color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                _deleteData(index);
                Navigator.of(context).pop();
              },
              child: Text('Eliminar', style: TextStyle(fontSize: 18, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cerrar Sesión', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          content: Text('¿Seguro que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar', style: TextStyle(fontSize: 18, color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                _authService.logout();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text('Cerrar Sesión', style: TextStyle(fontSize: 18, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formulario',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddDataDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _dataList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        _dataList[index],
                        style: TextStyle(fontSize: 18),
                      ),
                      leading: Icon(Icons.data_usage, size: 40, color: Colors.deepPurple),
                      onTap: () {
                        setState(() {
                          _selectedItemIndex = index;
                        });
                      },
                      tileColor: _selectedItemIndex == index ? Colors.blue : null,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, size: 30, color: Colors.blue),
                            onPressed: () {
                              _showEditDataDialog(context, index);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, size: 30, color: Colors.red),
                            onPressed: () {
                              _showDeleteDataDialog(context, index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDataDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 76, 76, 175),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Desarrollado por Cipa Los Reales',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
