import 'package:flutter/material.dart';

class MetaForm extends StatefulWidget {
  final void Function(double) onSubmit;

  const MetaForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  _MetaFormState createState() => _MetaFormState();
}

class _MetaFormState extends State<MetaForm> {
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
                labelText: 'Valor (R\$)',
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