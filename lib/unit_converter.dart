import 'package:flutter/material.dart';
import 'unit.dart';
import 'category.dart';
import 'api.dart';

class UnitConverter extends StatefulWidget {
  final Category category;

  const UnitConverter({Key? key, required this.category}) : super(key: key);

  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  late Unit _fromUnit;
  late Unit _toUnit;
  String _inputValue = '';
  String _conversionResult = '';
  bool _inputHasError = false;
  bool _apiError = false; // Flag to track API errors

  @override
  void initState() {
    super.initState();
    _setDefaults();
  }

  void _setDefaults() {
    _fromUnit = widget.category.units.first;
    _toUnit = widget.category.units.first;
  }

  void _updateConversion() async {
    final input = double.tryParse(_inputValue);
    if (input == null) {
      setState(() {
        _conversionResult = '';
        _inputHasError = true;
      });
      return;
    }

    setState(() {
      _inputHasError = false;
    });

    if (widget.category.name == 'Currency') {
      final api = Api();
      final conversion = await api.convert(
        category: 'currency',
        from: _fromUnit.name,
        to: _toUnit.name,
        amount: input,
      );

      setState(() {
        if (conversion != null) {
          _conversionResult = conversion.toStringAsFixed(2);
          _apiError = false;
        } else {
          _apiError = true;
          _conversionResult = '';
        }
      });
    } else {
      setState(() {
        _conversionResult =
            (input * (_toUnit.conversion / _fromUnit.conversion)).toStringAsFixed(2);
        _apiError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter value',
                errorText: _inputHasError ? 'Invalid input' : null,
              ),
              onChanged: (value) {
                setState(() {
                  _inputValue = value;
                  _updateConversion();
                });
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButton<Unit>(
              value: _fromUnit,
              items: widget.category.units
                  .map((unit) => DropdownMenuItem(value: unit, child: Text(unit.name)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _fromUnit = value;
                    _updateConversion();
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            const Icon(Icons.compare_arrows, size: 40.0),
            const SizedBox(height: 16.0),
            DropdownButton<Unit>(
              value: _toUnit,
              items: widget.category.units
                  .map((unit) => DropdownMenuItem(value: unit, child: Text(unit.name)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _toUnit = value;
                    _updateConversion();
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            _apiError
                ? Column(
                    children: const [
                      Icon(Icons.error, color: Colors.red, size: 40.0),
                      SizedBox(height: 8.0),
                      Text(
                        'API Error: Please check your internet connection.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  )
                : Text(
                    _conversionResult.isEmpty ? 'Conversion result' : _conversionResult,
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }
}
