import 'package:flutter/material.dart';
import 'package:flutter_websocket_demo/components/avatar.dart';
import 'package:flutter_websocket_demo/components/dismissible_scope.dart';
import 'package:flutter_websocket_demo/components/outline_input.dart';
import 'package:flutter_websocket_demo/constants/constants.dart';
import 'package:flutter_websocket_demo/screens/main_screen.dart';
import 'package:flutter_websocket_demo/view_models/app_model.dart';
import 'package:provider/provider.dart';

class EntryScreen extends StatefulWidget {
  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  TextEditingController _nameController;
  TextEditingController _hostController;
  AppModel _appModel;

  Widget _buildFloatingActionButton() => FloatingActionButton(
      child: Icon(Icons.navigate_next_rounded, size: 28),
      tooltip: '前往聊天室',
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            _appModel.initConnection();
            return ChangeNotifierProvider.value(value: _appModel, child: MainScreen());
          })));

  Widget _buildAvatarList() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Constants.figures
                .map((person) => Avatar(person: person, selected: _appModel.person.avatar == person.avatar))
                .toList()),
      );

  @override
  void initState() {
    _nameController = TextEditingController(text: Constants.figures.first.name);
    _hostController = TextEditingController(text: Constants.route);

    _nameController.addListener(() {
      if (_appModel != null) {
        _appModel.name = _nameController.text.trim();
      }
    });

    _hostController.addListener(() {
      if (_appModel != null) _appModel.host = _hostController.text.trim();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _appModel = Provider.of<AppModel>(context)..addListener(() => _nameController.text = _appModel.person.name);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissibleScope(
        child: Scaffold(
            appBar: AppBar(title: Text('Let\'s Chat'), centerTitle: true),
            floatingActionButton: _buildFloatingActionButton(),
            body: Container(
              child: Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                _buildAvatarList(),
                SizedBox(height: 40),
                OutlineInput(
                    controller: _nameController, icon: Icons.person, labelText: '名稱', placeholder: "請輸入欲顯示的使用者名稱"),
                OutlineInput(
                    controller: _hostController, icon: Icons.cloud, labelText: '伺服器位址', placeholder: "請輸入WebSocket位址"),
              ])),
            )));
  }
}
