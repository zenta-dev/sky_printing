import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sky_printing_core/sky_printing_core.dart';
import 'package:sky_printing_data/models/printer/printer_model.dart';
import 'package:sky_printing_domain/sky_printing_domain.dart';
 
class PostPrinterSyncBulkUsecase
    extends UseCase<List<PrinterEntity>, PostPrinterSyncBulkParams> {
  final PrinterRepository _repo;

  PostPrinterSyncBulkUsecase(this._repo);

  @override
  Future<Either<Failure, List<PrinterEntity>>> call(
          PostPrinterSyncBulkParams params) =>
      _repo.postPrinterSyncBulk(params);
}
