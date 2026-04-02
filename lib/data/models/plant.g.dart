// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlantCollection on Isar {
  IsarCollection<Plant> get plants => this.collection();
}

const PlantSchema = CollectionSchema(
  name: r'Plant',
  id: 3202799289401311532,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'daysSinceLastWatering': PropertySchema(
      id: 1,
      name: r'daysSinceLastWatering',
      type: IsarType.long,
    ),
    r'isArchived': PropertySchema(
      id: 2,
      name: r'isArchived',
      type: IsarType.bool,
    ),
    r'isFavorite': PropertySchema(
      id: 3,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'lastCareDate': PropertySchema(
      id: 4,
      name: r'lastCareDate',
      type: IsarType.dateTime,
    ),
    r'lastCleaned': PropertySchema(
      id: 5,
      name: r'lastCleaned',
      type: IsarType.dateTime,
    ),
    r'lastFertilized': PropertySchema(
      id: 6,
      name: r'lastFertilized',
      type: IsarType.dateTime,
    ),
    r'lastMisted': PropertySchema(
      id: 7,
      name: r'lastMisted',
      type: IsarType.dateTime,
    ),
    r'lastPruned': PropertySchema(
      id: 8,
      name: r'lastPruned',
      type: IsarType.dateTime,
    ),
    r'lastRepotted': PropertySchema(
      id: 9,
      name: r'lastRepotted',
      type: IsarType.dateTime,
    ),
    r'lastWatered': PropertySchema(
      id: 10,
      name: r'lastWatered',
      type: IsarType.dateTime,
    ),
    r'lightCondition': PropertySchema(
      id: 11,
      name: r'lightCondition',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 12,
      name: r'name',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 13,
      name: r'notes',
      type: IsarType.string,
    ),
    r'photoPath': PropertySchema(
      id: 14,
      name: r'photoPath',
      type: IsarType.string,
    ),
    r'room': PropertySchema(
      id: 15,
      name: r'room',
      type: IsarType.string,
    ),
    r'species': PropertySchema(
      id: 16,
      name: r'species',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 17,
      name: r'status',
      type: IsarType.string,
    )
  },
  estimateSize: _plantEstimateSize,
  serialize: _plantSerialize,
  deserialize: _plantDeserialize,
  deserializeProp: _plantDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'reminders': LinkSchema(
      id: 9055085693607461878,
      name: r'reminders',
      target: r'Reminder',
      single: false,
    ),
    r'growthEntries': LinkSchema(
      id: -4505990327849092702,
      name: r'growthEntries',
      target: r'GrowthEntry',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _plantGetId,
  getLinks: _plantGetLinks,
  attach: _plantAttach,
  version: '3.1.0+1',
);

int _plantEstimateSize(
  Plant object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.lightCondition;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
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
  {
    final value = object.room;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.species;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _plantSerialize(
  Plant object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeLong(offsets[1], object.daysSinceLastWatering);
  writer.writeBool(offsets[2], object.isArchived);
  writer.writeBool(offsets[3], object.isFavorite);
  writer.writeDateTime(offsets[4], object.lastCareDate);
  writer.writeDateTime(offsets[5], object.lastCleaned);
  writer.writeDateTime(offsets[6], object.lastFertilized);
  writer.writeDateTime(offsets[7], object.lastMisted);
  writer.writeDateTime(offsets[8], object.lastPruned);
  writer.writeDateTime(offsets[9], object.lastRepotted);
  writer.writeDateTime(offsets[10], object.lastWatered);
  writer.writeString(offsets[11], object.lightCondition);
  writer.writeString(offsets[12], object.name);
  writer.writeString(offsets[13], object.notes);
  writer.writeString(offsets[14], object.photoPath);
  writer.writeString(offsets[15], object.room);
  writer.writeString(offsets[16], object.species);
  writer.writeString(offsets[17], object.status);
}

Plant _plantDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Plant();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.isArchived = reader.readBool(offsets[2]);
  object.isFavorite = reader.readBool(offsets[3]);
  object.lastCleaned = reader.readDateTimeOrNull(offsets[5]);
  object.lastFertilized = reader.readDateTimeOrNull(offsets[6]);
  object.lastMisted = reader.readDateTimeOrNull(offsets[7]);
  object.lastPruned = reader.readDateTimeOrNull(offsets[8]);
  object.lastRepotted = reader.readDateTimeOrNull(offsets[9]);
  object.lastWatered = reader.readDateTimeOrNull(offsets[10]);
  object.lightCondition = reader.readStringOrNull(offsets[11]);
  object.name = reader.readString(offsets[12]);
  object.notes = reader.readStringOrNull(offsets[13]);
  object.photoPath = reader.readStringOrNull(offsets[14]);
  object.room = reader.readStringOrNull(offsets[15]);
  object.species = reader.readStringOrNull(offsets[16]);
  object.status = reader.readStringOrNull(offsets[17]);
  return object;
}

P _plantDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _plantGetId(Plant object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _plantGetLinks(Plant object) {
  return [object.reminders, object.growthEntries];
}

void _plantAttach(IsarCollection<dynamic> col, Id id, Plant object) {
  object.id = id;
  object.reminders
      .attach(col, col.isar.collection<Reminder>(), r'reminders', id);
  object.growthEntries
      .attach(col, col.isar.collection<GrowthEntry>(), r'growthEntries', id);
}

extension PlantQueryWhereSort on QueryBuilder<Plant, Plant, QWhere> {
  QueryBuilder<Plant, Plant, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlantQueryWhere on QueryBuilder<Plant, Plant, QWhereClause> {
  QueryBuilder<Plant, Plant, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Plant, Plant, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterWhereClause> idBetween(
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

extension PlantQueryFilter on QueryBuilder<Plant, Plant, QFilterCondition> {
  QueryBuilder<Plant, Plant, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      daysSinceLastWateringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'daysSinceLastWatering',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      daysSinceLastWateringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'daysSinceLastWatering',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      daysSinceLastWateringEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysSinceLastWatering',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      daysSinceLastWateringGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysSinceLastWatering',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      daysSinceLastWateringLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysSinceLastWatering',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      daysSinceLastWateringBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysSinceLastWatering',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> isArchivedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isArchived',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> isFavoriteEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCareDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastCareDate',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCareDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastCareDate',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCareDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastCareDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCareDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastCareDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCareDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastCareDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCareDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastCareDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCleanedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastCleaned',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCleanedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastCleaned',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCleanedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastCleaned',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCleanedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastCleaned',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCleanedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastCleaned',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastCleanedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastCleaned',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastFertilizedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastFertilized',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastFertilizedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastFertilized',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastFertilizedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastFertilized',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastFertilizedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastFertilized',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastFertilizedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastFertilized',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastFertilizedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastFertilized',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastMistedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMisted',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastMistedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMisted',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastMistedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMisted',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastMistedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMisted',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastMistedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMisted',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastMistedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMisted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastPrunedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastPruned',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastPrunedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastPruned',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastPrunedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPruned',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastPrunedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPruned',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastPrunedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPruned',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastPrunedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPruned',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastRepottedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastRepotted',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastRepottedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastRepotted',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastRepottedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRepotted',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastRepottedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRepotted',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastRepottedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRepotted',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastRepottedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRepotted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastWateredIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastWatered',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastWateredIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastWatered',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastWateredEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastWatered',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastWateredGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastWatered',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastWateredLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastWatered',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lastWateredBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastWatered',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lightCondition',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lightCondition',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightCondition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lightCondition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lightCondition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lightCondition',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lightCondition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lightCondition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lightCondition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lightCondition',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightCondition',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> lightConditionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lightCondition',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesEqualTo(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesGreaterThan(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesLessThan(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesBetween(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesStartsWith(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesEndsWith(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoPath',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoPath',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathEqualTo(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathGreaterThan(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathLessThan(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathBetween(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathStartsWith(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathEndsWith(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> photoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'room',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'room',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'room',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'room',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'room',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> roomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'room',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'species',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'species',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'species',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'species',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'species',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> speciesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'species',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }
}

extension PlantQueryObject on QueryBuilder<Plant, Plant, QFilterCondition> {}

extension PlantQueryLinks on QueryBuilder<Plant, Plant, QFilterCondition> {
  QueryBuilder<Plant, Plant, QAfterFilterCondition> reminders(
      FilterQuery<Reminder> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'reminders');
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> remindersLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'reminders', length, true, length, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> remindersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'reminders', 0, true, 0, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> remindersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'reminders', 0, false, 999999, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> remindersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'reminders', 0, true, length, include);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> remindersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'reminders', length, include, 999999, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> remindersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'reminders', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> growthEntries(
      FilterQuery<GrowthEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'growthEntries');
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> growthEntriesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'growthEntries', length, true, length, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> growthEntriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'growthEntries', 0, true, 0, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> growthEntriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'growthEntries', 0, false, 999999, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> growthEntriesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'growthEntries', 0, true, length, include);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      growthEntriesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'growthEntries', length, include, 999999, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> growthEntriesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'growthEntries', lower, includeLower, upper, includeUpper);
    });
  }
}

extension PlantQuerySortBy on QueryBuilder<Plant, Plant, QSortBy> {
  QueryBuilder<Plant, Plant, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByDaysSinceLastWatering() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysSinceLastWatering', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByDaysSinceLastWateringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysSinceLastWatering', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastCareDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCareDate', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastCareDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCareDate', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastCleaned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCleaned', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastCleanedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCleaned', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastFertilized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFertilized', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastFertilizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFertilized', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastMisted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMisted', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastMistedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMisted', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastPruned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPruned', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastPrunedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPruned', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastRepotted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRepotted', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastRepottedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRepotted', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastWatered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatered', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLastWateredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatered', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLightCondition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightCondition', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByLightConditionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightCondition', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySpecies() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySpeciesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension PlantQuerySortThenBy on QueryBuilder<Plant, Plant, QSortThenBy> {
  QueryBuilder<Plant, Plant, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByDaysSinceLastWatering() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysSinceLastWatering', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByDaysSinceLastWateringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysSinceLastWatering', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastCareDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCareDate', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastCareDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCareDate', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastCleaned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCleaned', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastCleanedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCleaned', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastFertilized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFertilized', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastFertilizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFertilized', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastMisted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMisted', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastMistedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMisted', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastPruned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPruned', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastPrunedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPruned', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastRepotted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRepotted', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastRepottedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRepotted', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastWatered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatered', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLastWateredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatered', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLightCondition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightCondition', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByLightConditionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightCondition', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySpecies() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySpeciesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension PlantQueryWhereDistinct on QueryBuilder<Plant, Plant, QDistinct> {
  QueryBuilder<Plant, Plant, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByDaysSinceLastWatering() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysSinceLastWatering');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isArchived');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByLastCareDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastCareDate');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByLastCleaned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastCleaned');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByLastFertilized() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastFertilized');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByLastMisted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMisted');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByLastPruned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPruned');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByLastRepotted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRepotted');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByLastWatered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastWatered');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByLightCondition(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lightCondition',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByPhotoPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByRoom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'room', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctBySpecies(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'species', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }
}

extension PlantQueryProperty on QueryBuilder<Plant, Plant, QQueryProperty> {
  QueryBuilder<Plant, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Plant, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Plant, int?, QQueryOperations> daysSinceLastWateringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysSinceLastWatering');
    });
  }

  QueryBuilder<Plant, bool, QQueryOperations> isArchivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isArchived');
    });
  }

  QueryBuilder<Plant, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<Plant, DateTime?, QQueryOperations> lastCareDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastCareDate');
    });
  }

  QueryBuilder<Plant, DateTime?, QQueryOperations> lastCleanedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastCleaned');
    });
  }

  QueryBuilder<Plant, DateTime?, QQueryOperations> lastFertilizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastFertilized');
    });
  }

  QueryBuilder<Plant, DateTime?, QQueryOperations> lastMistedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMisted');
    });
  }

  QueryBuilder<Plant, DateTime?, QQueryOperations> lastPrunedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPruned');
    });
  }

  QueryBuilder<Plant, DateTime?, QQueryOperations> lastRepottedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRepotted');
    });
  }

  QueryBuilder<Plant, DateTime?, QQueryOperations> lastWateredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastWatered');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> lightConditionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lightCondition');
    });
  }

  QueryBuilder<Plant, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> photoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoPath');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> roomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'room');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> speciesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'species');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
