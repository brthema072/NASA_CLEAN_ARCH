import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_convert.dart';
import 'package:nasa_clean_arch/features/data/datasources/nasa_datasource_implementation.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_arch/features/presenter/controller/home_store.dart';
import 'package:http/http.dart' as http;

import 'features/presenter/pages/home_page.dart';
import 'features/presenter/pages/picture_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStore(i())),
    Bind.lazySingleton((i) => GetSpaceMediaFromDateUseCase(i())),
    Bind.lazySingleton((i) => SpaceMediaRepositoryImplementation(i())),
    Bind.lazySingleton((i) => NasaDatasourceImplementation(i())),
    Bind.lazySingleton((i) => http.Client()),
    Bind.lazySingleton((i) => DateToStringConvert()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute('/picture', child: (_, args) => PicturePage.fromArgs(args.data)),
  ];
}
