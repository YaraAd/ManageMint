
import '../../../Core/Services/firebase_task_service.dart';
import 'task_state.dart';

class InProgressState extends TaskState {
  @override
  String get statusLabel => 'In Progress';
}