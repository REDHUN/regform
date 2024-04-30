import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_reg_event.dart';
part 'student_reg_state.dart';

class StudentRegBloc extends Bloc<StudentRegEvent, StudentRegState> {
  StudentRegBloc() : super(StudentRegInitial()) {
    on<StudentRegEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
