# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Items(models.Model):
    id = models.UUIDField(primary_key=True)
    name = models.TextField(unique=True)

    class Meta:
        managed = False
        db_table = 'items'


class Pokemon(models.Model):
    id = models.UUIDField(primary_key=True)
    species = models.ForeignKey('PokemonSpecies', models.DO_NOTHING)
    nickname = models.TextField()
    trainer = models.ForeignKey('Trainer', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'pokemon'


class PokemonSpecies(models.Model):
    id = models.UUIDField(primary_key=True)
    name = models.TextField(unique=True)

    class Meta:
        managed = False
        db_table = 'pokemon_species'


class PokemonType(models.Model):
    id = models.UUIDField(primary_key=True)
    name = models.TextField(unique=True)

    class Meta:
        managed = False
        db_table = 'pokemon_type'


class SpeciesType(models.Model):
    species = models.OneToOneField(PokemonSpecies, models.DO_NOTHING, primary_key=True)
    type = models.ForeignKey(PokemonType, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'species_type'
        unique_together = (('species', 'type'),)


class Trainer(models.Model):
    id = models.UUIDField(primary_key=True)
    name = models.TextField(unique=True)

    class Meta:
        managed = False
        db_table = 'trainer'


class TrainerItems(models.Model):
    trainer = models.OneToOneField(Trainer, models.DO_NOTHING, primary_key=True)
    item = models.ForeignKey(Items, models.DO_NOTHING)
    quantity = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'trainer_items'
        unique_together = (('trainer', 'item'),)


class TypeWeakness(models.Model):
    type = models.OneToOneField(PokemonType, models.DO_NOTHING, primary_key=True)
    weak_against = models.ForeignKey(PokemonType, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'type_weakness'
        unique_together = (('type', 'weak_against'),)
