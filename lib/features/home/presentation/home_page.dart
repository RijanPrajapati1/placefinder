import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:placefinder/resources/app_color.dart';
import 'package:placefinder/routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> dummyPlaces = const [
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
    {
      "name": "Swayambhunath",
      "category": "Monument",
      "image": "https://images.unsplash.com/photo-1587135941948-670b381f08ce",
      "description": "Monkey Temple with city view",
      "address": "Swayambhu, Kathmandu",
      "lat": 27.7149,
      "lng": 85.2906,
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
    {
      "name": "Swayambhunath",
      "category": "Monument",
      "image": "https://images.unsplash.com/photo-1587135941948-670b381f08ce",
      "description": "Monkey Temple with city view",
      "address": "Swayambhu, Kathmandu",
      "lat": 27.7149,
      "lng": 85.2906,
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
    {
      "name": "Swayambhunath",
      "category": "Monument",
      "image": "https://images.unsplash.com/photo-1587135941948-670b381f08ce",
      "description": "Monkey Temple with city view",
      "address": "Swayambhu, Kathmandu",
      "lat": 27.7149,
      "lng": 85.2906,
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
    {
      "name": "Swayambhunath",
      "category": "Monument",
      "image": "https://images.unsplash.com/photo-1587135941948-670b381f08ce",
      "description": "Monkey Temple with city view",
      "address": "Swayambhu, Kathmandu",
      "lat": 27.7149,
      "lng": 85.2906,
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
    {
      "name": "Swayambhunath",
      "category": "Monument",
      "image": "https://images.unsplash.com/photo-1587135941948-670b381f08ce",
      "description": "Monkey Temple with city view",
      "address": "Swayambhu, Kathmandu",
      "lat": 27.7149,
      "lng": 85.2906,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColor.primary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(Routes.account);
              },

              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1.5),
                ),

                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.grey, size: 18),
                ),
              ),
            ),
          ),
        ],
      ),

      body: dummyPlaces.isEmpty
          ? const Center(
              child: Text(
                "No places found",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dummyPlaces.length,
              itemBuilder: (context, index) {
                final place = dummyPlaces[index];

                return GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.placeDetailsPage, extra: place);
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
                        // IMAGE WITH SAFE HANDLING
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

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: AppColor.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
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
    );
  }
}
