part of mtl_reading.statement_builders;

const _intIlluminationModelMap = const {
  0: IlluminationModel.illum0,
  1: IlluminationModel.illum1,
  2: IlluminationModel.illum2,
  3: IlluminationModel.illum3,
  4: IlluminationModel.illum4,
  5: IlluminationModel.illum5,
  6: IlluminationModel.illum6,
  7: IlluminationModel.illum7,
  8: IlluminationModel.illum8,
  9: IlluminationModel.illum9,
  10: IlluminationModel.illum10
};

class IllumStatementBuilder implements MtlStatementBuilder {
  final int lineNumber;

  IlluminationModel _model;

  int _argumentCount = 0;

  List<MtlReadingError> _errors = [];

  IllumStatementBuilder(this.lineNumber);

  void addStringArgument(String argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'illum', _argumentCount, 'String', ['int']));
    }

    _argumentCount++;
  }

  void addIntArgument(int argument) {
    if (_enforceMaxArgumentCount()) {
      _model = _intIlluminationModelMap[argument];

      if (_model == null) {
        _errors.add(new MtlReadingError(lineNumber,
            '`$argument` is not a valid illumination model identifier.'));
      }
    }

    _argumentCount++;
  }

  void addDoubleArgument(double argument) {
    if (_enforceMaxArgumentCount()) {
      _errors.add(new ArgumentTypeError(
          lineNumber, 'illum', _argumentCount, 'double', ['int']));
    }

    _argumentCount++;
  }

  MtlStatementResult build() {
    if (_argumentCount < 1) {
      _errors.add(new MtlReadingError(
          lineNumber, 'An `illum` statement requires 1 argument.'));
    }

    if (_errors.isEmpty) {
      return new MtlStatementResult._success(
          new IllumStatement(_model, lineNumber: lineNumber));
    } else {
      return new MtlStatementResult._failure(_errors);
    }
  }

  bool _enforceMaxArgumentCount() {
    if (_argumentCount >= 1) {
      _errors.add(new MtlReadingError(
          lineNumber, 'An `illum` statement only takes 1 argument.'));

      return false;
    } else {
      return true;
    }
  }
}
