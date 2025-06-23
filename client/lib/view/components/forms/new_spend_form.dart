import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewSpendForm extends StatefulWidget {
  const NewSpendForm({ super.key});

  @override
  State<NewSpendForm> createState() => NewSpendFormState();
}

class NewSpendFormState extends State<NewSpendForm> {
  late TextEditingController locationController;
  late TextEditingController dateController;
  late TextEditingController amountController;
  late TextEditingController notesController;
  String? selectedCategory;
  String? selectedRecurring;

  final formKey = GlobalKey<FormState>();
  final List<String> categories = ['Food', 'Travel', 'Utilities', 'Entertainment', 'Other'];
  final List<String> recurring = ['One Time', 'Daily', 'Weekly', 'Monthly', 'Yearly'];

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? dateInput = await showDatePicker(
      context: context, 
      firstDate: DateTime(2000), 
      lastDate: DateTime.now()
    );

    if (dateInput == null) {
      return;
    }

    setState(() {
      dateController.text = DateFormat('yyyy-MM-dd').format(dateInput);
    });
  }

  @override
  void initState() {
    super.initState();
    selectedRecurring = 'One Time';
    locationController = TextEditingController();
    amountController = TextEditingController();
    dateController = TextEditingController();
    notesController = TextEditingController();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  void dispose() {
    locationController.dispose();
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const double inputGap = 5;

    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 15),
          TextFormField(
            controller: dateController,
            decoration: const InputDecoration(
              labelText: 'Date',
              suffixIcon: Icon(Icons.calendar_today),
              helperText: '',
              errorStyle: TextStyle(height: 0, fontSize: 14),
              errorMaxLines: 1,
            ),
            readOnly: true,
            validator: (value) => value == null || value == "" ? 'Required' : null,
            onTap: () => selectDateTime(context),
          ),
          const SizedBox(height: inputGap),
          TextFormField(
            controller: locationController,
            decoration: const InputDecoration(
              labelText: 'Spent At',
              helperText: '',
              errorStyle: TextStyle(height: 0, fontSize: 14),
              errorMaxLines: 1,
            ),
            validator: (value) => value == null || value.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: inputGap),
          TextFormField(
            controller: amountController,
            decoration: const InputDecoration(
              labelText: 'Amount (\$)',
              prefixText: '\$ ',
              helperText: '',
              errorStyle: TextStyle(height: 0, fontSize: 14),
              errorMaxLines: 1,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            validator: (value) => value == null || value == "" ? 'Required' : null,
          ),
          const SizedBox(height: inputGap),
          DropdownButtonFormField<String>(
            value: selectedCategory,
            decoration: const InputDecoration(
              labelText: 'Category',
              helperText: '',
              errorStyle: TextStyle(height: 0, fontSize: 14),
              errorMaxLines: 1,
            ),
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: ((value) {
              selectedCategory = value;
            }),
            validator: (value) => value == null || value == "" ? 'Required' : null,
          ),
          DropdownButtonFormField<String>(
            value: selectedRecurring,
            decoration: const InputDecoration(
              labelText: 'Recurring',
              helperText: '',
              errorStyle: TextStyle(height: 0, fontSize: 14),
              errorMaxLines: 1,
            ),
            items: recurring.map((recurring) {
              return DropdownMenuItem<String>(
                value: recurring,
                child: Text(recurring),
              );
            }).toList(),
            onChanged: ((value) {
              selectedRecurring = value;
            }),
            validator: (value) => value == null || value == "" ? 'Required' : null,
          ),
          TextFormField(
            maxLines: 3,
            minLines: 1, 
            controller: notesController,
            decoration: const InputDecoration(
              labelText: 'Notes',
              helperText: '',
              errorStyle: TextStyle(height: 0, fontSize: 14),
              errorMaxLines: 1,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) => value == null || value == "" ? 'Required' : null,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => {
                  if (formKey.currentState != null && formKey.currentState!.validate()) {
                    print('Form Submitted')
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    formKey.currentState?.reset();
                    locationController.clear();
                    amountController.clear();
                    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
                    selectedCategory = null;
                  });
                },
                child: const Text('Clear'),
              ),
            ],
          )
        ],
      )
    );
  }
}
