import 'package:flutter/material.dart';
import '../models/provider.dart';

class ProviderProfilePage extends StatelessWidget {
  final ProviderModel? provider;
  const ProviderProfilePage({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    // Use mock data if no provider is passed
    final p =
        provider ??
        ProviderModel(
          id: 'provider_001',
          name: 'Alex Johnson',
          photoUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
          skills: ['Plumbing', 'Pipe Repair', 'Leak Fix'],
          description:
              'Experienced plumber with 10+ years in residential and commercial repairs. Reliable, fast, and affordable.',
          contact: 'alex.johnson@email.com',
          rating: 4.8,
          reviewIds: ['review1', 'review2', 'review3'],
          hourlyRate: 50.0,
          yearsOfExperience: 10,
          certifications: ['Certified Plumber', 'Water Damage Specialist'],
          serviceArea: 'Downtown, Uptown, Suburbs',
          portfolioImages: [
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
            'https://images.unsplash.com/photo-1464983953574-0892a716854b',
            'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
          ],
        );

    return Scaffold(
      appBar: AppBar(title: Text(p.name, style: Theme.of(context).appBarTheme.titleTextStyle)), 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Book Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () async {
                    final result =
                        await showModalBottomSheet<Map<String, dynamic>>(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (context) =>
                              _BookingSheet(providerName: p.name),
                        );
                    if (result != null) {
                      // Show Lottie animation for booking success
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (ctx) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 160,
                                height: 160,
                                child: Center(
                                  child: Image.network(
                                    'https://assets10.lottiefiles.com/packages/lf20_jbrw3hcz.json',
                                    errorBuilder: (ctx, err, stack) => Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 100,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Booking Confirmed!',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () => Navigator.of(ctx).pop(),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Center(
                child: Hero(
                  tag: 'provider_avatar_${p.name}',
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(p.photoUrl),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  p.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber[700]),
                  const SizedBox(width: 4),
                  Text(
                    p.rating.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('Skills:', style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8,
                children: p.skills
                    .map((skill) => Chip(label: Text(skill)))
                    .toList(),
              ),
              const SizedBox(height: 16),
              Text('About:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(p.description),
              const SizedBox(height: 16),
              Text('Contact:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(p.contact),
              const SizedBox(height: 16),
              Text('Portfolio:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: p.portfolioImages.length,
                  separatorBuilder: (context, i) => const SizedBox(width: 10),
                  itemBuilder: (context, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      p.portfolioImages[i],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Reviews:', style: TextStyle(fontWeight: FontWeight.bold)),
              // Replace p.reviews with a placeholder or fetch logic
              ...p.reviewIds.map(
                (id) => ListTile(
                  leading: Icon(Icons.comment, color: Colors.blueGrey[300]),
                  title: Text('Review ID: ' + id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookingSheet extends StatefulWidget {
  final String providerName;
  const _BookingSheet({required this.providerName});

  @override
  State<_BookingSheet> createState() => _BookingSheetState();
}

class _BookingSheetState extends State<_BookingSheet> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Book ${widget.providerName}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(
              _selectedDate == null
                  ? 'Select date'
                  : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
            ),
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: now,
                lastDate: now.add(const Duration(days: 365)),
              );
              if (picked != null) setState(() => _selectedDate = picked);
            },
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text(
              _selectedTime == null
                  ? 'Select time'
                  : _selectedTime!.format(context),
            ),
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) setState(() => _selectedTime = picked);
            },
          ),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Notes (optional)',
              prefixIcon: Icon(Icons.note_alt_outlined),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_selectedDate != null && _selectedTime != null)
                  ? () {
                      Navigator.of(context).pop({
                        'date': _selectedDate,
                        'time': _selectedTime,
                        'notes': _notesController.text,
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Confirm Booking',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
