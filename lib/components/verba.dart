// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class VerbaForm extends StatefulWidget {
  final void Function(double) onSubmit;

  const VerbaForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  _VerbaFormState createState() => _VerbaFormState();
}

class _VerbaFormState extends State<VerbaForm> {
  final _valueController = TextEditingController();

  void _submitForm() {
    final value = double.tryParse(_valueController.text) ?? 0;

    if (value <= 0) {
      return;
    }

    widget.onSubmit(value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$):',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  child: Text(
                    'Enviar',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.button?.color,
                    ),
                  ),
                  onPressed: _submitForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}