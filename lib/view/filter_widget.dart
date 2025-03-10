import 'package:flutter/material.dart';
import 'package:nex2u/models/states/filter_response.dart';
import 'package:nex2u/models/states/states_response.dart';
import 'package:provider/provider.dart';

import '../viewModel/state_view_model.dart';

class FilterSelectionWidget extends StatefulWidget {
  const FilterSelectionWidget({super.key});

  @override
  FilterSelectionWidgetState createState() => FilterSelectionWidgetState();
}

class FilterSelectionWidgetState extends State<FilterSelectionWidget> {
  /// List of States
  List<StatesList> states = [];

  /// List of Regions
  List<StatesList> regions = [];

  List<StatesList> area = [];

  List<SoilType> soiltype = [];

  List<CropType> croptype = [];

  List<Facility> facilities = [];

  /// Selected Values
  String? selectedState;
  String? selectedRegion;
  String? selectedArea;

  Set<String> selectedSoilTypes = {};
  Set<String> selectedCropTypes = {};
  Set<String> selectedFacilities = {};

  RangeValues budgetRange = const RangeValues(15, 80);

  /// Search Queries
  String stateSearchQuery = '';
  String regionSearchQuery = '';
  String areaSearchQuery = '';

  String soilSearchQuery = '';
  String cropSearchQuery = '';
  String facilitiesSearchQuery = '';

  @override
  void initState() {
    super.initState();
    loadStates();
  }

  Future<void> loadStates() async {
    final stateprovider = Provider.of<StateViewModel>(context, listen: false);
    await stateprovider.getstates(context);
    debugPrint("Received state response: ${stateprovider.stateResponse}");

    setState(() {
      states = stateprovider.stateResponse?.stateslist ?? [];
    });

    await stateprovider.getfilter(context);

    setState(() {
      croptype = stateprovider.filterResponse?.cropTypes ?? [];
      soiltype = stateprovider.filterResponse?.soilTypes ?? [];
      facilities = stateprovider.filterResponse?.facilities ?? [];
    });
  }

  Future<void> loadCities() async {
    final stateProvider = Provider.of<StateViewModel>(context, listen: false);
    await stateProvider.getregion(context, selectedState.toString());
    debugPrint("Received district response: ${stateProvider.stateResponse}");

    setState(() {
      regions = stateProvider.stateResponse?.stateslist ?? [];
    });
  }

  Future<void> loadAreas() async {
    final stateProvider = Provider.of<StateViewModel>(context, listen: false);
    await stateProvider.getarea(context, selectedRegion.toString());
    debugPrint("Received area response: ${stateProvider.stateResponse}");

    setState(() {
      area = stateProvider.stateResponse?.stateslist ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          /// Header
          const SizedBox(height: 30), // Spacing between text and icon
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
                        onSelect: (id) {
                          setState(() {
                            selectedState = id;
                            selectedRegion =
                                null; // Reset selected region when state changes
                            regions.clear(); // Clear previous region data
                            area.clear(); // Clear previous region data
                          });
                          loadCities(); // Fetch cities for the newly selected state
                        },
                      ),

                      const SizedBox(height: 15),

                      /// Search by Regions (Only if a state is selected)
                      //if (selectedState != null)
                      _buildSearchSection(
                        title: "Search By Regions",
                        searchHint: "e.g. West Godavari",
                        searchQuery: regionSearchQuery,
                        onSearch: (query) =>
                            setState(() => regionSearchQuery = query),
                        items: regions,
                        selectedItem: selectedRegion,
                        onSelect: (id) {
                          setState(() {
                            selectedRegion = id;
                            selectedArea =
                                null; // Reset selected region when state changes
                            area.clear(); // Clear previous region data
                          });
                          loadAreas(); // Fetch cities for the newly selected state
                        },
                      ),

                      const SizedBox(height: 15),

                      /// Search by Area (Only if a region is selected)
                      // if (selectedRegion != null)

                      _buildSearchSection(
                        title: "Search By Area",
                        searchHint: "e.g. Tanuku",
                        searchQuery: areaSearchQuery,
                        onSearch: (query) =>
                            setState(() => areaSearchQuery = query),
                        items: area,
                        selectedItem: selectedArea,
                        onSelect: (id) => setState(() => selectedArea = id),
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
                            const Text(
                              "Search By Budget",
                              style: TextStyle(
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
                              width: double.infinity,
                              // Ensures full width inside the container
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

                      _buildMultiSelectSection(
                        title: "Soil Type",
                        searchHint: "e.g. Irrigation",
                        searchQuery: soilSearchQuery,
                        onSearch: (query) =>
                            setState(() => soilSearchQuery = query),
                        items: soiltype,
                        selectedItems: selectedSoilTypes,
                        getItemId: (item) => item.id,
                        getItemLabel: (item) => item.label,
                        onSelect: (id) => setState(() {
                          selectedSoilTypes.contains(id)
                              ? selectedSoilTypes.remove(id)
                              : selectedSoilTypes.add(id);
                        }),
                      ),

                      const SizedBox(height: 15),

                      _buildMultiSelectSection(
                        title: "Crop Type",
                        searchHint: "e.g. Irrigation",
                        searchQuery: cropSearchQuery,
                        onSearch: (query) =>
                            setState(() => cropSearchQuery = query),
                        items: croptype,
                        selectedItems: selectedCropTypes,
                        getItemId: (item) => item.id,
                        getItemLabel: (item) => item.label,
                        onSelect: (id) => setState(() {
                          selectedCropTypes.contains(id)
                              ? selectedCropTypes.remove(id)
                              : selectedCropTypes.add(id);
                        }),
                      ),

                      const SizedBox(height: 15),
                      _buildMultiSelectSection(
                        title: "Available Facilities",
                        searchHint: "e.g. Irrigation",
                        searchQuery: facilitiesSearchQuery,
                        onSearch: (query) =>
                            setState(() => facilitiesSearchQuery = query),
                        items: facilities,
                        selectedItems: selectedFacilities,
                        getItemId: (item) => item.id,
                        getItemLabel: (item) => item.label,
                        onSelect: (id) => setState(() {
                          selectedFacilities.contains(id)
                              ? selectedFacilities.remove(id)
                              : selectedFacilities.add(id);
                        }),
                      ),

                      const SizedBox(height: 15),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint("Selected State: $selectedState");
                            debugPrint("Selected Region: $selectedRegion");
                            debugPrint("Selected Region: $selectedArea");
                            List<String> soilTypesList =
                                selectedSoilTypes.toList();
                            List<String> cropTypesList =
                                selectedCropTypes.toList();
                            List<String> facilitiesTypesList =
                                selectedFacilities.toList();
                            debugPrint("Selected Region: $soilTypesList");
                            debugPrint("Selected Region: $cropTypesList");
                            debugPrint("Selected Region: $facilitiesTypesList");
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
    required List<StatesList> items,
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
                    .toString()
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .map((item) {
              return CheckboxListTile(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                value: selectedItem == item.id,
                onChanged: (bool? value) {
                  if (value == true) {
                    onSelect(item.id.toString());
                  }
                },
                title: Text(item.label.toString()),
                controlAffinity: ListTileControlAffinity.leading,
                // Checkbox left
                activeColor: Colors.blueAccent,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiSelectSection<T>({
    required String title,
    required String searchHint,
    required String searchQuery,
    required Function(String) onSearch,
    required List<T> items,
    required Set<String> selectedItems,
    required String Function(T) getItemId,
    required String Function(T) getItemLabel,
    required Function(String) onSelect,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
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
          Column(
            children: items
                .where((item) => getItemLabel(item)
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .map((item) {
              String id = getItemId(item);
              return CheckboxListTile(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                value: selectedItems.contains(id),
                onChanged: (bool? value) {
                  setState(() {
                    if (selectedItems.contains(id)) {
                      selectedItems.remove(id);
                    } else {
                      selectedItems.add(id);
                    }
                  });
                },
                title: Text(getItemLabel(item)),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.blueAccent,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
