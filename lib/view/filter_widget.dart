import 'package:flutter/material.dart';

/// Model Class for State and Region
class StateModel {
  final String id;
  final String label;

  StateModel({required this.id, required this.label});
}

class FilterSelectionWidget extends StatefulWidget {
  const FilterSelectionWidget({super.key});

  @override
  FilterSelectionWidgetState createState() => FilterSelectionWidgetState();
}

class FilterSelectionWidgetState extends State<FilterSelectionWidget> {
  /// List of States
  List<StateModel> states = [
    StateModel(id: "1", label: "Andaman and Nicobar Islands"),
    StateModel(id: "2", label: "Andhra Pradesh"),
    StateModel(id: "3", label: "Telangana"),
    StateModel(id: "4", label: "Karnataka"),
    StateModel(id: "5", label: "Tamil Nadu"),
    StateModel(id: "6", label: "Orissa"),
    StateModel(id: "7", label: "Maharashtra"),
  ];

  /// List of Regions
  List<StateModel> regions = [
    StateModel(id: "1", label: "West Godavari"),
    StateModel(id: "2", label: "East Godavari"),
    StateModel(id: "3", label: "Krishna"),
    StateModel(id: "4", label: "Kurnool"),
    StateModel(id: "5", label: "Guntur"),
    StateModel(id: "6", label: "Srikakulam"),
  ];

  /// Selected Values
  String? selectedState;
  String? selectedRegion;

  /// Search Queries
  String stateSearchQuery = '';
  String regionSearchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filter",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),

            const SizedBox(height: 10),

            /// Search by State
            _buildSearchSection(
              title: "Search By State",
              searchHint: "e.g. Andhra Pradesh",
              searchQuery: stateSearchQuery,
              onSearch: (query) => setState(() => stateSearchQuery = query),
              items: states,
              selectedItem: selectedState,
              onSelect: (id) => setState(() => selectedState = id),
            ),

            const SizedBox(height: 15),

            /// Search by Regions
            _buildSearchSection(
              title: "Search By Regions",
              searchHint: "e.g. West Godavari",
              searchQuery: regionSearchQuery,
              onSearch: (query) => setState(() => regionSearchQuery = query),
              items: regions,
              selectedItem: selectedRegion,
              onSelect: (id) => setState(() => selectedRegion = id),
            ),

            const SizedBox(height: 20),

            /// Apply Button
            ElevatedButton(
              onPressed: () {
                print("Selected State: $selectedState");
                print("Selected Region: $selectedRegion");
                Navigator.pop(context);
              },
              child: const Text("Apply"),
            )
          ],
        ),
      ),
    );
  }

  /// Widget for Search + Checkbox List
  Widget _buildSearchSection({
    required String title,
    required String searchHint,
    required String searchQuery,
    required Function(String) onSearch,
    required List<StateModel> items, // Using Model instead of Map
    required String? selectedItem,
    required Function(String) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),

        /// Search Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: searchHint,
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),

        const SizedBox(height: 10),

        /// Checkbox List
        SizedBox(
          height: 150, // Scrollable height
          child: ListView(
            children: items
                .where((item) => item.label
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .map((item) {
              return CheckboxListTile(
                value: selectedItem == item.id,
                onChanged: (bool? value) {
                  if (value == true) {
                    onSelect(item.id);
                  }
                },
                title: Text(item.label), // Accessing model property
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.blueAccent,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
