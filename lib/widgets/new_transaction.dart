import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTx;

  NewTransaction(this._addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitInput() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget._addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 7,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              CupertinoTextField(
                padding: EdgeInsets.all(15),
                clearButtonMode: OverlayVisibilityMode.editing,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0)),
                placeholder: 'Title',
                controller: _titleController,
                onSubmitted: (_) => _submitInput(),
                prefix: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.title),
                ),
              ),
              CupertinoTextField(
                padding: EdgeInsets.all(15),
                clearButtonMode: OverlayVisibilityMode.editing,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0)),
                placeholder: 'Amount',
                controller: _amountController,
                onSubmitted: (_) => _submitInput(),
                prefix: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.numberWithOptions(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : DateFormat.yMMMMEEEEd().format(_selectedDate),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  _submitInput();
                },
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: Theme.of(context).primaryColor,
                // textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
