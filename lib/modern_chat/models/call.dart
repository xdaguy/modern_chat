enum CallType { audio, video }
enum CallStatus { incoming, outgoing, missed }

class Call {
  final String id;
  final String userId;
  final CallType type;
  final CallStatus status;
  final DateTime timestamp;
  final int duration; // in seconds

  Call({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.timestamp,
    this.duration = 0,
  });
}

// Sample calls data
final List<Call> sampleCalls = [
  Call(
    id: '1',
    userId: '1', // Emma Watson
    type: CallType.video,
    status: CallStatus.outgoing,
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    duration: 185,
  ),
  Call(
    id: '2',
    userId: '3', // Sophia Chen
    type: CallType.audio,
    status: CallStatus.incoming,
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    duration: 360,
  ),
  // Add more calls...
]; 