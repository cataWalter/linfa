import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/constants/strings.dart';

void main() {
  group('AppStrings', () {
    test('appName should be Linfa', () {
      expect(AppStrings.appName, 'Linfa');
    });

    test('appTagline should be correct', () {
      expect(
          AppStrings.appTagline, 'Il Tuo Assistente per le Piante Domestiche');
    });

    group('Navigation', () {
      test('home should be correct', () {
        expect(AppStrings.home, 'Home');
      });

      test('myPlants should be correct', () {
        expect(AppStrings.myPlants, 'Le Mie Piante');
      });

      test('reminders should be correct', () {
        expect(AppStrings.reminders, 'Promemoria');
      });

      test('settings should be correct', () {
        expect(AppStrings.settings, 'Impostazioni');
      });

      test('growth should be correct', () {
        expect(AppStrings.growth, 'Crescita');
      });
    });

    group('Home Screen', () {
      test('greeting should be correct', () {
        expect(AppStrings.greeting, 'Buongiorno');
      });

      test('greetingEvening should be correct', () {
        expect(AppStrings.greetingEvening, 'Buonasera');
      });

      test('greetingAfternoon should be correct', () {
        expect(AppStrings.greetingAfternoon, 'Buon pomeriggio');
      });

      test('upcomingReminders should be correct', () {
        expect(AppStrings.upcomingReminders, 'Promemoria Imminenti');
      });

      test('noUpcomingReminders should be correct', () {
        expect(AppStrings.noUpcomingReminders, 'Nessun promemoria imminente');
      });

      test('plantsNeedingWater should be correct', () {
        expect(AppStrings.plantsNeedingWater, 'Piante da annaffiare oggi');
      });

      test('totalPlants should be correct', () {
        expect(AppStrings.totalPlants, 'Piante Totali');
      });

      test('quickActions should be correct', () {
        expect(AppStrings.quickActions, 'Azioni Rapide');
      });
    });

    group('Plant Screen', () {
      test('addPlant should be correct', () {
        expect(AppStrings.addPlant, 'Aggiungi Pianta');
      });

      test('editPlant should be correct', () {
        expect(AppStrings.editPlant, 'Modifica Pianta');
      });

      test('plantName should be correct', () {
        expect(AppStrings.plantName, 'Nome Pianta');
      });

      test('plantNameHint should be correct', () {
        expect(AppStrings.plantNameHint, 'Es. Monstera Deliziosa');
      });

      test('species should be correct', () {
        expect(AppStrings.species, 'Specie');
      });

      test('speciesHint should be correct', () {
        expect(AppStrings.speciesHint, 'Seleziona o inserisci specie');
      });

      test('room should be correct', () {
        expect(AppStrings.room, 'Stanza');
      });

      test('roomHint should be correct', () {
        expect(AppStrings.roomHint, 'Es. Soggiorno, Cucina, Camera');
      });

      test('addRoom should be correct', () {
        expect(AppStrings.addRoom, 'Aggiungi Stanza');
      });

      test('lightCondition should be correct', () {
        expect(AppStrings.lightCondition, 'Condizione Luce');
      });

      test('lightDirect should be correct', () {
        expect(AppStrings.lightDirect, 'Diretta');
      });

      test('lightIndirect should be correct', () {
        expect(AppStrings.lightIndirect, 'Indiretta');
      });

      test('lightLow should be correct', () {
        expect(AppStrings.lightLow, 'Bassa');
      });

      test('plantStatus should be correct', () {
        expect(AppStrings.plantStatus, 'Stato');
      });

      test('statusHealthy should be correct', () {
        expect(AppStrings.statusHealthy, 'Sana');
      });

      test('statusStressed should be correct', () {
        expect(AppStrings.statusStressed, 'Stressata');
      });

      test('statusDormant should be correct', () {
        expect(AppStrings.statusDormant, 'Dormiente');
      });

      test('statusRecovering should be correct', () {
        expect(AppStrings.statusRecovering, 'In Recupero');
      });

      test('notes should be correct', () {
        expect(AppStrings.notes, 'Note');
      });

      test('notesHint should be correct', () {
        expect(AppStrings.notesHint, 'Aggiungi note sulla tua pianta...');
      });

      test('deletePlant should be correct', () {
        expect(AppStrings.deletePlant, 'Elimina Pianta');
      });

      test('deletePlantConfirm should be correct', () {
        expect(AppStrings.deletePlantConfirm,
            'Sei sicuro di voler eliminare questa pianta? Tutti i dati associati verranno persi.');
      });
    });

    group('Reminder Screen', () {
      test('addReminder should be correct', () {
        expect(AppStrings.addReminder, 'Aggiungi Promemoria');
      });

      test('editReminder should be correct', () {
        expect(AppStrings.editReminder, 'Modifica Promemoria');
      });

      test('reminderType should be correct', () {
        expect(AppStrings.reminderType, 'Tipo Promemoria');
      });

      test('typeWatering should be correct', () {
        expect(AppStrings.typeWatering, 'Annaffiare');
      });

      test('typeFertilizing should be correct', () {
        expect(AppStrings.typeFertilizing, 'Concimare');
      });

      test('typeRepotting should be correct', () {
        expect(AppStrings.typeRepotting, 'Rinvasare');
      });

      test('typeCleaning should be correct', () {
        expect(AppStrings.typeCleaning, 'Pulire Foglie');
      });

      test('typePruning should be correct', () {
        expect(AppStrings.typePruning, 'Potare');
      });

      test('typeMisting should be correct', () {
        expect(AppStrings.typeMisting, 'Nebulizzare');
      });

      test('reminderFrequency should be correct', () {
        expect(AppStrings.reminderFrequency, 'Frequenza');
      });

      test('reminderTime should be correct', () {
        expect(AppStrings.reminderTime, 'Ora');
      });

      test('reminderEnabled should be correct', () {
        expect(AppStrings.reminderEnabled, 'Promemoria Attivo');
      });

      test('everyDay should be correct', () {
        expect(AppStrings.everyDay, 'Ogni giorno');
      });

      test('everyWeek should be correct', () {
        expect(AppStrings.everyWeek, 'Ogni settimana');
      });

      test('every2Weeks should be correct', () {
        expect(AppStrings.every2Weeks, 'Ogni 2 settimane');
      });

      test('everyMonth should be correct', () {
        expect(AppStrings.everyMonth, 'Ogni mese');
      });

      test('deleteReminder should be correct', () {
        expect(AppStrings.deleteReminder, 'Elimina Promemoria');
      });

      test('deleteReminderConfirm should be correct', () {
        expect(AppStrings.deleteReminderConfirm,
            'Sei sicuro di voler eliminare questo promemoria?');
      });

      test('nextReminder should be correct', () {
        expect(AppStrings.nextReminder, 'Prossimo promemoria');
      });

      test('overdue should be correct', () {
        expect(AppStrings.overdue, 'Scaduto');
      });

      test('today should be correct', () {
        expect(AppStrings.today, 'Oggi');
      });

      test('tomorrow should be correct', () {
        expect(AppStrings.tomorrow, 'Domani');
      });
    });

    group('Growth Screen', () {
      test('addGrowthEntry should be correct', () {
        expect(AppStrings.addGrowthEntry, 'Aggiungi Entry Crescita');
      });

      test('growthPhoto should be correct', () {
        expect(AppStrings.growthPhoto, 'Foto Crescita');
      });

      test('growthNote should be correct', () {
        expect(AppStrings.growthNote, 'Nota Crescita');
      });

      test('height should be correct', () {
        expect(AppStrings.height, 'Altezza');
      });

      test('heightHint should be correct', () {
        expect(AppStrings.heightHint, 'Es. 30 cm');
      });

      test('newLeaves should be correct', () {
        expect(AppStrings.newLeaves, 'Nuove Foglie');
      });

      test('healthRating should be correct', () {
        expect(AppStrings.healthRating, 'Valutazione Salute');
      });

      test('deleteEntry should be correct', () {
        expect(AppStrings.deleteEntry, 'Elimina Entry');
      });

      test('deleteEntryConfirm should be correct', () {
        expect(AppStrings.deleteEntryConfirm,
            'Sei sicuro di voler eliminare questa entry?');
      });

      test('growthTimeline should be correct', () {
        expect(AppStrings.growthTimeline, 'Timeline Crescita');
      });

      test('noGrowthEntries should be correct', () {
        expect(AppStrings.noGrowthEntries, 'Nessuna entry crescita ancora');
      });

      test('addFirstPhoto should be correct', () {
        expect(AppStrings.addFirstPhoto, 'Aggiungi la prima foto!');
      });
    });

    group('Settings Screen', () {
      test('generalSettings should be correct', () {
        expect(AppStrings.generalSettings, 'Impostazioni Generali');
      });

      test('theme should be correct', () {
        expect(AppStrings.theme, 'Tema');
      });

      test('themeSystem should be correct', () {
        expect(AppStrings.themeSystem, 'Sistema');
      });

      test('themeLight should be correct', () {
        expect(AppStrings.themeLight, 'Chiaro');
      });

      test('themeDark should be correct', () {
        expect(AppStrings.themeDark, 'Scuro');
      });

      test('language should be correct', () {
        expect(AppStrings.language, 'Lingua');
      });

      test('notifications should be correct', () {
        expect(AppStrings.notifications, 'Notifiche');
      });

      test('notificationSound should be correct', () {
        expect(AppStrings.notificationSound, 'Suono Notifica');
      });

      test('notificationEnabled should be correct', () {
        expect(AppStrings.notificationEnabled, 'Notifiche Abilitate');
      });

      test('dataManagement should be correct', () {
        expect(AppStrings.dataManagement, 'Gestione Dati');
      });

      test('exportData should be correct', () {
        expect(AppStrings.exportData, 'Esporta Dati');
      });

      test('exportSuccess should be correct', () {
        expect(AppStrings.exportSuccess, 'Dati esportati con successo');
      });

      test('exportError should be correct', () {
        expect(AppStrings.exportError, 'Errore durante l\'esportazione');
      });

      test('importData should be correct', () {
        expect(AppStrings.importData, 'Importa Dati');
      });

      test('importSuccess should be correct', () {
        expect(AppStrings.importSuccess, 'Dati importati con successo');
      });

      test('importError should be correct', () {
        expect(AppStrings.importError, 'Errore durante l\'importazione');
      });

      test('clearData should be correct', () {
        expect(AppStrings.clearData, 'Elimina Tutti i Dati');
      });

      test('clearDataConfirm should be correct', () {
        expect(AppStrings.clearDataConfirm,
            'Sei sicuro? Questa azione è irreversibile.');
      });

      test('dataCleared should be correct', () {
        expect(AppStrings.dataCleared, 'Dati eliminati');
      });

      test('about should be correct', () {
        expect(AppStrings.about, 'Informazioni');
      });

      test('version should be correct', () {
        expect(AppStrings.version, 'Versione');
      });

      test('license should be correct', () {
        expect(AppStrings.license, 'Licenza MIT');
      });

      test('github should be correct', () {
        expect(AppStrings.github, 'GitHub');
      });

      test('privacyPolicy should be correct', () {
        expect(AppStrings.privacyPolicy, 'Privacy Policy');
      });

      test('privacyNote should be correct', () {
        expect(AppStrings.privacyNote,
            'Tutti i dati restano sul tuo dispositivo. Nessun dato viene inviato a server esterni.');
      });
    });

    group('Common', () {
      test('save should be correct', () {
        expect(AppStrings.save, 'Salva');
      });

      test('cancel should be correct', () {
        expect(AppStrings.cancel, 'Annulla');
      });

      test('delete should be correct', () {
        expect(AppStrings.delete, 'Elimina');
      });

      test('edit should be correct', () {
        expect(AppStrings.edit, 'Modifica');
      });

      test('add should be correct', () {
        expect(AppStrings.add, 'Aggiungi');
      });

      test('done should be correct', () {
        expect(AppStrings.done, 'Fatto');
      });

      test('ok should be correct', () {
        expect(AppStrings.ok, 'OK');
      });

      test('yes should be correct', () {
        expect(AppStrings.yes, 'Sì');
      });

      test('no should be correct', () {
        expect(AppStrings.no, 'No');
      });

      test('search should be correct', () {
        expect(AppStrings.search, 'Cerca');
      });

      test('searchHint should be correct', () {
        expect(AppStrings.searchHint, 'Cerca pianta...');
      });

      test('sortBy should be correct', () {
        expect(AppStrings.sortBy, 'Ordina per');
      });

      test('sortName should be correct', () {
        expect(AppStrings.sortName, 'Nome');
      });

      test('sortLastWatered should be correct', () {
        expect(AppStrings.sortLastWatered, 'Ultima Annaffiatura');
      });

      test('sortRecentlyAdded should be correct', () {
        expect(AppStrings.sortRecentlyAdded, 'Aggiunte Recentemente');
      });

      test('filter should be correct', () {
        expect(AppStrings.filter, 'Filtra');
      });

      test('filterByRoom should be correct', () {
        expect(AppStrings.filterByRoom, 'Filtra per Stanza');
      });

      test('allRooms should be correct', () {
        expect(AppStrings.allRooms, 'Tutte le Stanze');
      });

      test('noPlants should be correct', () {
        expect(AppStrings.noPlants, 'Nessuna pianta ancora');
      });

      test('addFirstPlant should be correct', () {
        expect(AppStrings.addFirstPlant, 'Aggiungi la tua prima pianta!');
      });

      test('noReminders should be correct', () {
        expect(AppStrings.noReminders, 'Nessun promemoria');
      });

      test('loading should be correct', () {
        expect(AppStrings.loading, 'Caricamento...');
      });

      test('error should be correct', () {
        expect(AppStrings.error, 'Errore');
      });

      test('retry should be correct', () {
        expect(AppStrings.retry, 'Riprova');
      });

      test('photo should be correct', () {
        expect(AppStrings.photo, 'Foto');
      });

      test('takePhoto should be correct', () {
        expect(AppStrings.takePhoto, 'Scatta Foto');
      });

      test('chooseFromGallery should be correct', () {
        expect(AppStrings.chooseFromGallery, 'Scegli dalla Galleria');
      });

      test('removePhoto should be correct', () {
        expect(AppStrings.removePhoto, 'Rimuovi Foto');
      });

      test('permissionDenied should be correct', () {
        expect(AppStrings.permissionDenied, 'Permesso negato');
      });

      test('permissionCamera should be correct', () {
        expect(AppStrings.permissionCamera, 'Permesso fotocamera necessario');
      });

      test('permissionStorage should be correct', () {
        expect(
            AppStrings.permissionStorage, 'Permesso archiviazione necessario');
      });

      test('permissionPhotos should be correct', () {
        expect(AppStrings.permissionPhotos, 'Permesso foto necessario');
      });
    });

    group('Plant Types', () {
      test('difficultyEasy should be correct', () {
        expect(AppStrings.difficultyEasy, 'Facile');
      });

      test('difficultyMedium should be correct', () {
        expect(AppStrings.difficultyMedium, 'Media');
      });

      test('difficultyHard should be correct', () {
        expect(AppStrings.difficultyHard, 'Difficile');
      });

      test('plantTypeLightIndirectBright should be correct', () {
        expect(AppStrings.plantTypeLightIndirectBright, 'Indiretta Brillante');
      });

      test('plantTypeLightIndirect should be correct', () {
        expect(AppStrings.plantTypeLightIndirect, 'Indiretta');
      });

      test('plantTypeLightDirect should be correct', () {
        expect(AppStrings.plantTypeLightDirect, 'Diretta');
      });

      test('plantTypeLightLow should be correct', () {
        expect(AppStrings.plantTypeLightLow, 'Bassa');
      });

      test('humidityLow should be correct', () {
        expect(AppStrings.humidityLow, 'Bassa');
      });

      test('humidityMedium should be correct', () {
        expect(AppStrings.humidityMedium, 'Media');
      });

      test('humidityHigh should be correct', () {
        expect(AppStrings.humidityHigh, 'Alta');
      });
    });

    group('Export', () {
      test('exportFormat should be correct', () {
        expect(AppStrings.exportFormat, 'Formato Esportazione');
      });

      test('exportJSON should be correct', () {
        expect(AppStrings.exportJSON, 'JSON');
      });

      test('exportCSV should be correct', () {
        expect(AppStrings.exportCSV, 'CSV');
      });

      test('exportIncludePhotos should be correct', () {
        expect(AppStrings.exportIncludePhotos, 'Includi Foto');
      });

      test('exportPreparing should be correct', () {
        expect(AppStrings.exportPreparing, 'Preparazione esportazione...');
      });

      test('exportShare should be correct', () {
        expect(AppStrings.exportShare, 'Condividi Esportazione');
      });
    });

    group('Vacation Mode', () {
      test('vacationMode should be correct', () {
        expect(AppStrings.vacationMode, 'Modalità Vacanza');
      });

      test('vacationStart should be correct', () {
        expect(AppStrings.vacationStart, 'Data Inizio');
      });

      test('vacationEnd should be correct', () {
        expect(AppStrings.vacationEnd, 'Data Fine');
      });

      test('vacationActive should be correct', () {
        expect(AppStrings.vacationActive, 'Modalità Vacanza Attiva');
      });

      test('vacationReminder should be correct', () {
        expect(AppStrings.vacationReminder, 'Promemoria vacanza impostato');
      });
    });
  });
}
