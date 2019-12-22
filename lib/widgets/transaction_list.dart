import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _tx;
  final Function _deleteTx;

  TransactionList(this._tx, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return _tx.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.3,
                    child: Text('No Transactions Added'),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Text('\₹${_tx[index].amount}'),
                    ),
                  ),
                  title: Text(
                    _tx[index].title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMEEEEd().format(_tx[index].date),
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      _deleteTx(_tx[index].id);
                    },
                  ),
                ),
              );
            },
            itemCount: _tx.length,
          );
  }
}
