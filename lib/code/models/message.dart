

class Message {
//  final String id;
  final String from;
  final String content;
  final bool seen;
  final String timeStamp;

  Message({
    this.from,
    this.content,
    this.seen,
    this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'content': content,
      'seen': seen,
      'timeStamp': timeStamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> message) {
    return Message(
      from: message['from'],
      content: message['content'] ?? '',
      seen: message['seen'] ?? false,
      timeStamp: message['timeStamp'],
    );
  }
}
