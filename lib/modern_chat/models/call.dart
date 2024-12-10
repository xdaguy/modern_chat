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

  bool get isOutgoing => status == CallStatus.outgoing;
  bool get isMissed => status == CallStatus.missed;
  bool get isVideoCall => type == CallType.video;
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
  Call(
    id: '3',
    userId: '2', // James Rodriguez
    type: CallType.video,
    status: CallStatus.missed,
    timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    duration: 0,
  ),
  Call(
    id: '4',
    userId: '4', // Marcus Johnson
    type: CallType.audio,
    status: CallStatus.outgoing,
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    duration: 245,
  ),
  Call(
    id: '5',
    userId: '5', // Isabella Martinez
    type: CallType.video,
    status: CallStatus.incoming,
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    duration: 420,
  ),
  Call(
    id: '6',
    userId: '6', // Alexander White
    type: CallType.audio,
    status: CallStatus.missed,
    timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    duration: 0,
  ),
  Call(
    id: '7',
    userId: '7', // Olivia Brown
    type: CallType.video,
    status: CallStatus.outgoing,
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
    duration: 180,
  ),
  Call(
    id: '8',
    userId: '8', // Daniel Lee
    type: CallType.audio,
    status: CallStatus.incoming,
    timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
    duration: 300,
  ),
  Call(
    id: '9',
    userId: '1', // Emma Watson
    type: CallType.audio,
    status: CallStatus.outgoing,
    timestamp: DateTime.now().subtract(const Duration(days: 3)),
    duration: 155,
  ),
  Call(
    id: '10',
    userId: '3', // Sophia Chen
    type: CallType.video,
    status: CallStatus.missed,
    timestamp: DateTime.now().subtract(const Duration(days: 3, hours: 6)),
    duration: 0,
  ),
]; 