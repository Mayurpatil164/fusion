import 'package:flutter/material.dart';

class VisualizationFormPage extends StatefulWidget {
  const VisualizationFormPage({Key? key}) : super(key: key);

  @override
  State<VisualizationFormPage> createState() =>
      _VisualizationFormPageState();
}

class _VisualizationFormPageState extends State<VisualizationFormPage> {
  String? _selectedTaluka;
  String? _selectedCropName;
  String? _plotArea;
  String? _landType;

  TextEditingController _plotAreaController = TextEditingController();

  List<Map<String, String>> savedDataList = [];

  @override
  void dispose() {
    _plotAreaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: Text('Visualisation')),
      //   backgroundColor: Colors.orange,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedTaluka,
              onChanged: (value) {
                setState(() {
                  _selectedTaluka = value;
                });
              },
              items: [
                'धरणगाव',
                'अमळनेर',
                'भडगांव',
                'चोपडा',
                'पारोळा',
                'चाळीसगाव',
                'एरंडोल',
                'जामनेर',
                'मुक्ताईनगर',
                'पाचोरा',
                'भुसावळ',
                'बोडवड',
                'रावेर',
                'यावल',
                'जळगाव'
              ]
                  .map((taluka) => DropdownMenuItem<String>(
                value: taluka,
                child: Text(taluka),
              ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'तालुका निवडा',
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCropName,
              onChanged: (value) {
                setState(() {
                  _selectedCropName = value;
                });
              },
              items: [
                'कापूस',
                'कांदा',
                'मक्का',
                'ज्वारी',
                'बाजरी',
                'केळी',
                'बटाटा',
                'ऊस',
                'लसूण',
                'सूर्यफूल',
                'भुईमूग',
                'मुंग',
                'चवळी',
                'उडीद',
                'तूर',
                'हळद',
                'नागली'
              ]
                  .map((crop) => DropdownMenuItem<String>(
                value: crop,
                child: Text(crop),
              ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'पिकाचे नाव',
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: _plotAreaController,
                onChanged: (value) {
                  setState(() {
                    _plotArea = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'शेतीचे क्षेत्र दर्शवा(गुंठ्या मध्ये)',
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              value: _landType,
              onChanged: (value) {
                setState(() {
                  _landType = value;
                });
              },
              items: ['कोरडवाहू', 'जिरायत']
                  .map((crop) => DropdownMenuItem<String>(
                value: crop,
                child: Text(crop),
              ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'जमिनीचा प्रकार',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addPlotData();
                resetForm();
              },
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.greenAccent.shade400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: buildSavedDataList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addPlotData() {
    if (_selectedTaluka != null &&
        _selectedCropName != null &&
        _plotArea != null &&
        _landType != null) {
      Map<String, String> newData = {
        'Taluka': _selectedTaluka!,
        'Crop Name': _selectedCropName!,
        'Plot Area': _plotArea!,
        'Land Type': _landType!,
      };
      setState(() {
        savedDataList.add(newData);
      });
    }
  }

  void resetForm() {
    setState(() {
      _selectedTaluka = null;
      _selectedCropName = null;
      _plotAreaController.clear(); // Clear text field value
      _landType = null;
    });
  }

  Widget buildSavedDataList() {
    return DataTable(
        columns: [
          DataColumn(label: Text('Taluka')),
          DataColumn(label: Text('Crop Name')),
          DataColumn(label: Text('Plot Area')),
          DataColumn(label: Text('Land Type')),
        ],
        rows: savedDataList.map((data) {
          return DataRow(
            color: MaterialStateColor.resolveWith((states) => Colors.green),
            cells: [
              DataCell(Text(data['Taluka'] ?? '')),
              DataCell(Text(data['Crop Name'] ?? '')),
              DataCell(Text(data['Plot Area'] ?? '')),
              DataCell(Text(data['Land Type'] ?? '')),
            ],
          );
        }).toList(),
        );
   }
}