import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
      description: 'Descrção de teste',
      mediaType: 'image',
      title: 'Título de teste',
      mediaUrl: 'url de teste');

  final tDate = DateTime(2021, 11, 06);

  test('Should return space media model when calls the datasource', () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);

    final result = await repository.getSpaceMediaFromDate(tDate);
    expect(result, Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate));
  });

  test(
      'Should return a server failure when the calls to datasource is unsuccessful',
      () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());

    final result = await repository.getSpaceMediaFromDate(tDate);
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate));
  });
}
