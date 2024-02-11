enum FieldsCodeStyle {
  none,
  snake,
  pascal,
  kebab,
}

class Fields {
  final bool includePrivate;
  final bool includeStatic;
  final bool generateEnum;
  final FieldsCodeStyle caseStyle;

  const Fields({
    this.includePrivate = false,
    this.includeStatic = false,
    this.generateEnum = false,
    this.caseStyle = FieldsCodeStyle.none,
  });
}
