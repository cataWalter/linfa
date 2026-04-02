// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGrowthEntryCollection on Isar {
  IsarCollection<GrowthEntry> get growthEntrys => this.collection();
}

const GrowthEntrySchema = CollectionSchema(
  name: r'GrowthEntry',
  id: 2736737740535977883,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'entryType': PropertySchema(
      id: 1,
      name: r'entryType',
      type: IsarType.string,
    ),
    r'healthRating': PropertySchema(
      id: 2,
      name: r'healthRating',
      type: IsarType.long,
    ),
    r'heightCm': PropertySchema(
      id: 3,
      name: r'heightCm',
      type: IsarType.double,
    ),
    r'newLeaves': PropertySchema(
      id: 4,
      name: r'newLeaves',
      type: IsarType.long,
    ),
    r'notes': PropertySchema(
      id: 5,
      name: r'notes',
      type: IsarType.string,
    ),
    r'photoPath': PropertySchema(
      id: 6,
      name: r'photoPath',
      type: IsarType.string,
    )
  },
  estimateSize: _growthEntryEstimateSize,
  serialize: _growthEntrySerialize,
  deserialize: _growthEntryDeserialize,
  deserializeProp: _growthEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'plant': LinkSchema(
      id: -1737067692699743056,
      name: r'plant',
      target: r'Plant',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _growthEntryGetId,
  getLinks: _growthEntryGetLinks,
  attach: _growthEntryAttach,
  version: '3.1.0+1',
);

int _growthEntryEstimateSize(
  GrowthEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.entryType.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.photoPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _growthEntrySerialize(
  GrowthEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeString(offsets[1], object.entryType);
  writer.writeLong(offsets[2], object.healthRating);
  writer.writeDouble(offsets[3], object.heightCm);
  writer.writeLong(offsets[4], object.newLeaves);
  writer.writeString(offsets[5], object.notes);
  writer.writeString(offsets[6], object.photoPath);
}

GrowthEntry _growthEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GrowthEntry();
  object.date = reader.readDateTime(offsets[0]);
  object.entryType = reader.readString(offsets[1]);
  object.healthRating = reader.readLongOrNull(offsets[2]);
  object.heightCm = reader.readDoubleOrNull(offsets[3]);
  object.id = id;
  object.newLeaves = reader.readLongOrNull(offsets[4]);
  object.notes = reader.readStringOrNull(offsets[5]);
  object.photoPath = reader.readStringOrNull(offsets[6]);
  return object;
}

P _growthEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _growthEntryGetId(GrowthEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _growthEntryGetLinks(GrowthEntry object) {
  return [object.plant];
}

void _growthEntryAttach(
    IsarCollection<dynamic> col, Id id, GrowthEntry object) {
  object.id = id;
  object.plant.attach(col, col.isar.collection<Plant>(), r'plant', id);
}

extension GrowthEntryQueryWhereSort
    on QueryBuilder<GrowthEntry, GrowthEntry, QWhere> {
  QueryBuilder<GrowthEntry, GrowthEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GrowthEntryQueryWhere
    on QueryBuilder<GrowthEntry, GrowthEntry, QWhereClause> {
  QueryBuilder<GrowthEntry, GrowthEntry, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GrowthEntryQueryFilter
    on QueryBuilder<GrowthEntry, GrowthEntry, QFilterCondition> {
  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      entryTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      entryTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      entryTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      entryTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      entryTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entryType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      entryTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entryType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      entryTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entryType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      entryTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entryType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      entryTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryType',
        value: '',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      entryTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entryType',
        value: '',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      healthRatingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'healthRating',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      healthRatingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'healthRating',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      healthRatingEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthRating',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      healthRatingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'healthRating',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      healthRatingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'healthRating',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      healthRatingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'healthRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      heightCmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'heightCm',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      heightCmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'heightCm',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> heightCmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      heightCmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      heightCmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> heightCmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'heightCm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      newLeavesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newLeaves',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      newLeavesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newLeaves',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      newLeavesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newLeaves',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      newLeavesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newLeaves',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      newLeavesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newLeaves',
        value: value,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      newLeavesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newLeaves',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoPath',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoPath',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition>
      photoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoPath',
        value: '',
      ));
    });
  }
}

extension GrowthEntryQueryObject
    on QueryBuilder<GrowthEntry, GrowthEntry, QFilterCondition> {}

extension GrowthEntryQueryLinks
    on QueryBuilder<GrowthEntry, GrowthEntry, QFilterCondition> {
  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> plant(
      FilterQuery<Plant> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'plant');
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterFilterCondition> plantIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'plant', 0, true, 0, true);
    });
  }
}

extension GrowthEntryQuerySortBy
    on QueryBuilder<GrowthEntry, GrowthEntry, QSortBy> {
  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByEntryType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryType', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByEntryTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryType', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByHealthRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthRating', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy>
      sortByHealthRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthRating', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByHeightCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByNewLeaves() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newLeaves', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByNewLeavesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newLeaves', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> sortByPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.desc);
    });
  }
}

extension GrowthEntryQuerySortThenBy
    on QueryBuilder<GrowthEntry, GrowthEntry, QSortThenBy> {
  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByEntryType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryType', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByEntryTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryType', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByHealthRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthRating', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy>
      thenByHealthRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthRating', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByHeightCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByNewLeaves() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newLeaves', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByNewLeavesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newLeaves', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.asc);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QAfterSortBy> thenByPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.desc);
    });
  }
}

extension GrowthEntryQueryWhereDistinct
    on QueryBuilder<GrowthEntry, GrowthEntry, QDistinct> {
  QueryBuilder<GrowthEntry, GrowthEntry, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QDistinct> distinctByEntryType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QDistinct> distinctByHealthRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'healthRating');
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QDistinct> distinctByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'heightCm');
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QDistinct> distinctByNewLeaves() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newLeaves');
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GrowthEntry, GrowthEntry, QDistinct> distinctByPhotoPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoPath', caseSensitive: caseSensitive);
    });
  }
}

extension GrowthEntryQueryProperty
    on QueryBuilder<GrowthEntry, GrowthEntry, QQueryProperty> {
  QueryBuilder<GrowthEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GrowthEntry, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<GrowthEntry, String, QQueryOperations> entryTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryType');
    });
  }

  QueryBuilder<GrowthEntry, int?, QQueryOperations> healthRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'healthRating');
    });
  }

  QueryBuilder<GrowthEntry, double?, QQueryOperations> heightCmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'heightCm');
    });
  }

  QueryBuilder<GrowthEntry, int?, QQueryOperations> newLeavesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newLeaves');
    });
  }

  QueryBuilder<GrowthEntry, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<GrowthEntry, String?, QQueryOperations> photoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoPath');
    });
  }
}
