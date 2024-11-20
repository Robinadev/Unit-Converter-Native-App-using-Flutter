import 'package:flutter/material.dart';
import 'category.dart';
import 'unit.dart';
import 'category_tile.dart';
import 'api.dart';
import 'unit_converter.dart';

class CategoryRoute extends StatefulWidget {
  const CategoryRoute({Key? key}) : super(key: key);

  @override
  _CategoryRouteState createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  late List<Category> _categories;
  bool _isCurrencyAvailable = true; // Tracks if the Currency API is accessible

  @override
  void initState() {
    super.initState();
    _categories = _loadCategories();
    _fetchCurrencyUnits();
  }

  List<Category> _loadCategories() {
    const lengthUnits = [
      Unit(name: 'Meter', conversion: 1.0),
      Unit(name: 'Kilometer', conversion: 1000.0),
    ];
    const massUnits = [
      Unit(name: 'Kilogram', conversion: 1.0),
      Unit(name: 'Gram', conversion: 1000.0),
    ];
    const timeUnits = [
      Unit(name: 'Second', conversion: 1.0),
      Unit(name: 'Minute', conversion: 60.0),
    ];

    return [
      Category(
        name: 'Length',
        color: Colors.blue,
        units: lengthUnits,
        icon: Icons.straighten,
      ),
      Category(
        name: 'Mass',
        color: Colors.green,
        units: massUnits,
        icon: Icons.scale,
      ),
      Category(
        name: 'Time',
        color: Colors.purple,
        units: timeUnits,
        icon: Icons.access_time,
      ),
    ];
  }

  Future<void> _fetchCurrencyUnits() async {
    final api = Api();
    final units = await api.getUnits('currency');
    if (units != null) {
      setState(() {
        _categories.add(
          Category(
            name: 'Currency',
            color: Colors.amber,
            units: units.map((unit) => Unit(name: unit, conversion: 1.0)).toList(),
            icon: Icons.attach_money,
          ),
        );
        _isCurrencyAvailable = true; // API is available
      });
    } else {
      setState(() {
        _isCurrencyAvailable = false; // API is unavailable
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
        backgroundColor: Colors.blueGrey,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.0,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          return CategoryTile(
            category: _categories[index],
            isDisabled: !_isCurrencyAvailable &&
                _categories[index].name == 'Currency', // Disable if unavailable
            onTap: () {
              if (_categories[index].name == 'Currency' && !_isCurrencyAvailable) {
                // Show an alert if the API is unavailable
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Currency conversion is unavailable. Check your connection.'),
                ));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UnitConverter(category: _categories[index]),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
