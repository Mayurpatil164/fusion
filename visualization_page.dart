import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fusion/data_visualization_model/visualization_form.dart';

class CropData {
  final String name;
  final double landArea;

  CropData(this.name, this.landArea);
}

class VisualizationPage extends StatelessWidget {
  final List<CropData> cropData = [
    CropData('Wheat', 50),
    CropData('Rice', 30),
    CropData('Corn', 20),
    CropData('Soybean', 40),
    CropData('Barley', 25),
    CropData('Cotton', 35),
    CropData('Potatoes', 15),
    CropData('Sugarcane', 45),
    CropData('Tomatoes', 10),
    CropData('Apples', 5),
  ];

  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.yellow,
    Colors.indigo,
    Colors.pink,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Data'),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.green[100],
            width: double.infinity, // Adjusted to occupy full width
            height: 400, // Adjust the height of the pie chart container
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChart(
                PieChartData(
                  sections: List.generate(
                    cropData.length,
                    (index) => PieChartSectionData(
                      color: colors[index % colors.length],
                      value: cropData[index].landArea,
                      radius: 168, // Adjusted radius for larger pie chart
                      title: '${cropData[index].name}',
                      titleStyle: TextStyle(
                        fontSize: 14, // Adjust the font size for crop names
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 0,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Crop Name')),
                DataColumn(label: Text('Land Area (acres)')),
              ],
              rows: cropData.map((data) {
                return DataRow(cells: [
                  DataCell(Text(data.name)),
                  DataCell(Text(data.landArea.toString())),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VisualizationFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
//
// void main() {
//   runApp(MaterialApp(
//     home: VisualizationPage(),
//   ));
// }
