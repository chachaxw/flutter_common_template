import 'package:flutter/cupertino.dart';
import 'package:flutter_common_template/http/env.dart';
import 'picker/picker.dart';

class SelectEnvDialog extends StatefulWidget {
  @override
  _SelectEnvDialogState createState() => _SelectEnvDialogState();
}

class _SelectEnvDialogState extends State<SelectEnvDialog> {
  int _pickerSelectedIndex = 0;
  List<AppEnvironment> list = envList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PickerDialog(
      picker: Container(
        child: Column(
          children: <Widget>[
            PickerHeader(
              title: '选择运行环境',
              onCancel: () => Navigator.pop(context),
              onConfirm: () {
                Map ret = {
                  "name": list[_pickerSelectedIndex].name,
                  "env": list[_pickerSelectedIndex],
                };
                Navigator.pop(context, ret);
              },
            ),
            Expanded(
              child: PickerBody(
                list: list,
                onChange: (int index) =>
                    setState(() => _pickerSelectedIndex = index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
