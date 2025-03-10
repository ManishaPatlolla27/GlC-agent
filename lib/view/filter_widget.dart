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

  Set<String> selectedSoilTypes = {};
  Set<String> selectedCropTypes = {};
  Set<String> selectedFacilities = {};

  RangeValues budgetRange = const RangeValues(15, 80);

  /// Search Queries
  String stateSearchQuery = '';
  String regionSearchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          /// Header
          SizedBox(height: 30), // Spacing between text and icon
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align items to the left
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8), // Spacing between close icon and text
                const Text(
                  "Filter",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const Divider(),

          /// Scrollable Content
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [],
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      /// Search by State
                      _buildSearchSection(
                        title: "Search By State",
                        searchHint: "e.g. Andhra Pradesh",
                        searchQuery: stateSearchQuery,
                        onSearch: (query) =>
                            setState(() => stateSearchQuery = query),
                        items: states,
                        selectedItem: selectedState,
                        onSelect: (id) => setState(() => selectedState = id),
                      ),

                      const SizedBox(height: 15),

                      /// Search by Regions (Only if a state is selected)
                      if (selectedState != null)
                        _buildSearchSection(
                          title: "Search By Regions",
                          searchHint: "e.g. West Godavari",
                          searchQuery: regionSearchQuery,
                          onSearch: (query) =>
                              setState(() => regionSearchQuery = query),
                          items: regions,
                          selectedItem: selectedRegion,
                          onSelect: (id) => setState(() => selectedRegion = id),
                        ),

                      const SizedBox(height: 15),

                      /// Search by Area (Only if a region is selected)
                      if (selectedRegion != null)
                        _buildSearchSection(
                          title: "Search By Area",
                          searchHint: "e.g. Tanuku",
                          searchQuery: regionSearchQuery,
                          onSearch: (query) =>
                              setState(() => regionSearchQuery = query),
                          items: regions,
                          selectedItem: selectedRegion,
                          onSelect: (id) => setState(() => selectedRegion = id),
                        ),

                      /// Budget Range Section with Black Border
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black), // Black border
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Search By Budget",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),

                            /// Row for Displaying Budget Range
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${budgetRange.start.toInt()} Lacs"),
                                Text("${budgetRange.end.toInt()} Lacs"),
                              ],
                            ),

                            /// Range Slider Matching Row Width
                            SizedBox(
                              width: double
                                  .infinity, // Ensures full width inside the container
                              child: RangeSlider(
                                values: budgetRange,
                                min: 5,
                                max: 200,
                                activeColor: const Color(0xFF8280FF),
                                inactiveColor: Colors.grey[300],
                                onChanged: (RangeValues values) {
                                  setState(() {
                                    budgetRange = values;
                                  });
                                },
                              ),
                            ),

                            /// Min and Max Labels
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("5 L",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12)),
                                Text("2 Cr",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildMultiSearchSection(
                        title: "Soil Type",
                        searchHint: "e.g. Irrigation",
                        searchQuery: regionSearchQuery,
                        onSearch: (query) =>
                            setState(() => regionSearchQuery = query),
                        items: regions, // Replace with actual facility data
                        selectedItems: selectedFacilities,
                        onSelect: (id) => setState(() {
                          if (selectedFacilities.contains(id)) {
                            selectedFacilities.remove(id);
                          } else {
                            selectedFacilities.add(id);
                          }
                        }),
                        isMultiSelect: true,
                      ),

                      const SizedBox(height: 15),

                      _buildMultiSearchSection(
                        title: "Crop Type",
                        searchHint: "e.g. Irrigation",
                        searchQuery: regionSearchQuery,
                        onSearch: (query) =>
                            setState(() => regionSearchQuery = query),
                        items: regions, // Replace with actual facility data
                        selectedItems: selectedFacilities,
                        onSelect: (id) => setState(() {
                          if (selectedFacilities.contains(id)) {
                            selectedFacilities.remove(id);
                          } else {
                            selectedFacilities.add(id);
                          }
                        }),
                        isMultiSelect: true,
                      ),

                      const SizedBox(height: 15),

                      _buildMultiSearchSection(
                        title: "Available Facilities",
                        searchHint: "e.g. Irrigation",
                        searchQuery: regionSearchQuery,
                        onSearch: (query) =>
                            setState(() => regionSearchQuery = query),
                        items: regions, // Replace with actual facility data
                        selectedItems: selectedFacilities,
                        onSelect: (id) => setState(() {
                          if (selectedFacilities.contains(id)) {
                            selectedFacilities.remove(id);
                          } else {
                            selectedFacilities.add(id);
                          }
                        }),
                        isMultiSelect: true,
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint("Selected State: $selectedState");
                            debugPrint("Selected Region: $selectedRegion");
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8280FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Search",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget for Search + Checkbox List
  Widget _buildSearchSection({
    required String title,
    required String searchHint,
    required String searchQuery,
    required Function(String) onSearch,
    required List<StateModel> items,
    required String? selectedItem,
    required Function(String) onSelect,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black), // Black border
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),

          /// Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: TextField(
                    onChanged: onSearch,
                    decoration: InputDecoration(
                      hintText: searchHint,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// Dynamic Checkbox List (No internal scrolling)
          Column(
            children: items
                .where((item) => item.label
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .map((item) {
              return CheckboxListTile(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                value: selectedItem == item.id,
                onChanged: (bool? value) {
                  if (value == true) {
                    onSelect(item.id);
                  }
                },
                title: Text(item.label),
                controlAffinity:
                    ListTileControlAffinity.leading, // Checkbox left
                activeColor: Colors.blueAccent,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiSearchSection({
    required String title,
    required String searchHint,
    required String searchQuery,
    required Function(String) onSearch,
    required List<StateModel> items,
    required Set<String?> selectedItems,
    required Function(String) onSelect,
    required bool isMultiSelect,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black), // Black border
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),

          /// Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: TextField(
                    onChanged: onSearch,
                    decoration: InputDecoration(
                      hintText: searchHint,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// Dynamic Checkbox List (Multi-Select Supported)
          Column(
            children: items
                .where((item) => item.label
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .map((item) {
              return CheckboxListTile(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                value: selectedItems.contains(item.id),
                onChanged: (bool? value) {
                  if (value == true) {
                    selectedItems.add(item.id);
                  } else {
                    selectedItems.remove(item.id);
                  }
                  onSelect(item.id);
                },
                title: Text(item.label),
                controlAffinity:
                    ListTileControlAffinity.leading, // Checkbox left
                activeColor: Colors.blueAccent,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
