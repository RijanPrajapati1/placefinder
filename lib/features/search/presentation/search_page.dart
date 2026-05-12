import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:placefinder/resources/app_color.dart';
import 'package:placefinder/routes/routes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> allPlaces = const [
    {
      "name": "Pashupatinath Temple",
      "category": "Temple",
      "image": "https://images.unsplash.com/photo-1609947017136-9daf32a5eb16",
      "description": "Famous Hindu temple in Kathmandu",
      "address": "Gaushala, Kathmandu",
      "lat": 27.7104,
      "lng": 85.3488,
    },
    {
      "name": "Boudhanath Stupa",
      "category": "Heritage",
      "image": "https://images.unsplash.com/photo-1576671081837-49000212a370",
      "description": "One of the largest stupas in Nepal",
      "address": "Boudha, Kathmandu",
      "lat": 27.7215,
      "lng": 85.3620,
    },
    {
      "name": "Swayambhunath",
      "category": "Monument",
      "image": "https://images.unsplash.com/photo-1587135941948-670b381f08ce",
      "description": "Monkey Temple with city view",
      "address": "Swayambhu, Kathmandu",
      "lat": 27.7149,
      "lng": 85.2906,
    },
  ];

  List<Map<String, dynamic>> filtered = [];

  @override
  void initState() {
    super.initState();
    filtered = allPlaces;
  }

  void search(String query) {
    setState(() {
      filtered = allPlaces.where((place) {
        final name = (place["name"] ?? "").toLowerCase();
        final category = (place["category"] ?? "").toLowerCase();
        final input = query.toLowerCase();

        return name.contains(input) || category.contains(input);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ✅ SAME APPBAR AS HOME
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColor.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Column(
        children: [
          // SEARCH FIELD (optional but clean)
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search places...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // LIST (SAME UI AS HOME PAGE)
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text(
                      "No places found",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final place = filtered[index];

                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            Routes.placeDetailsPage,
                            extra: place,
                          );
                        },

                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: Row(
                            children: [
                              // IMAGE (same as HomePage)
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  bottomLeft: Radius.circular(14),
                                ),
                                child: Image.network(
                                  place["image"] ?? "",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // TEXT
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        place["name"] ?? "Unknown",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColor.primary.withOpacity(
                                            0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          place["category"] ?? "",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        place["description"] ??
                                            "No description available",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
