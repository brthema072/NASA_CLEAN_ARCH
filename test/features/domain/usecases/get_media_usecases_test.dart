import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUseCase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();

    usecase = GetSpaceMediaFromDateUseCase(repository);
  });

  // ignore: prefer_const_constructors

  test('should get space media from media for a given date from the repository',
      () async {
    when(() => repository.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => Right<Failure, SpaceMediaEntity>(tSpaceMedia));
    final result = await usecase(tDate);
    expect(result, Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('Should return a ServerFailure whe don\'t succeed', () async {
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));

    final result = await usecase(tDate);
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(tDate));
  });

  test('Should return NullParamFailure when receives a null param', () async {
    final result = await usecase(null);

    expect(result, Left(NullParamFailure()));
    verifyNever(() => repository.getSpaceMediaFromDate(tDate));
  });
}
