import 'package:flutter/material.dart';
import 'package:rcss_frontend/service_implementation/index_service.dart';
import 'package:rcss_frontend/views/index_page_grid_view.dart';

import '../widgets/shortcut_icon.dart';

List<ShortcutIcon> shortcuts = [];

class IndexPage extends StatefulWidget {
  final String uuid;
  final String userName;

  const IndexPage({
    super.key,
    required this.uuid,
    required this.userName,
  });

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final IndexService _indexService = IndexService();

  @override
  void initState() {
    super.initState();
    getShortcutListJson(widget.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首頁'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    body: Container(
        child:IndexPageGridView(icons: shortcuts)
    ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              heroTag: 'Add',
              onPressed: () => _showCreateNewShortcutDialog(context),
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
          )
        ],
      ),
      /*body: Stack(
        children: [
          IndexPageGridView(icons: shortcuts),
          Row(
            children: [
              SizedBox(
                  height: 30,
                  child:GestureDetector(
                onLongPress: () => _showCreateNewShortcutDialog(context),
                )
              ),
            ],
          ),
        ],
      ),*/
    );
  }

  void getShortcutListJson(String uuid) async {
    List<dynamic> shortcutListJson = await _indexService.getShortcutList(uuid);

    shortcuts.clear();

    setState(() {
      for (Map<String, dynamic> shortcut in shortcutListJson) {
        shortcuts.add(
          ShortcutIcon(
            login_uuid: widget.uuid,
            uuid: uuid,
            userName: widget.userName,
            type: shortcut['shortcut_type_id'],
            imagePath: shortcut['icon'],
            title: shortcut['shortcut_title'],
            shortcutUrl: shortcut['shortcut_url'],
            unreadCount: shortcut['not_read_count'].toString(),
            onDelete: _updateShortcutsList,
          ),
        );
      }
    });
  }

  void _updateShortcutsList() {
    setState(() {
      getShortcutListJson(widget.uuid);
    });
  }
  void _showCreateNewShortcutDialog(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _urlController = TextEditingController();
    print('_showCreateNewShortcutDialog');
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '請輸入捷行名稱與網址.',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,color: Colors.red),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '捷徑名稱'),
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red)
            ),
            TextField(
                controller: _urlController,
                decoration: InputDecoration(labelText: '網址'),
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red)
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('取消',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                /*print(_titleController.text);
                print(_urlController.text);*/
                _indexService.createIndexPageShortcut(
                    widget.uuid,
                    5,
                    _titleController.text,
                    {'url': _urlController.text},
                    DateTime.now().toUtc().toString());
                Navigator.pop(context);
              },
              child: const Text('確定',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.red)),
            ),
          ],
        ),
      ),
    );
    /*showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('請輸入捷徑名稱與網址'),
            *//*content: Row(
                children: <Widget>[
                  TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: '捷徑名稱'),
            ),
              TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: '網址'))
            ]
            ),*//*
            content:
                  TextField(
                      controller: _urlController,
                      decoration: InputDecoration(labelText: '網址')
                  )
            ,
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () => {
                  *//*_indexService.createIndexPageShortcut(
                      uuid,
                      1,
                      _titleController.text,
                      {'business_id': this.business_id},
                      DateTime.now().toUtc().toString()),*//*
                  Navigator.pop(context)
                },
                child: Text('確認'),
              ),
            ],
          );
        });*/
  }
}
