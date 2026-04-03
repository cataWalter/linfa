# Linfa - Il Tuo Assistente per le Piante Domestiche

Linfa è un'applicazione mobile open source per tenere traccia delle tue piante domestiche, impostare promemoria per la cura, e osservare la loro crescita nel tempo. Semplice, privata, e completamente gratuita.

## Il Problema

Le piante domestiche richiedono cure regolari: annaffiatura, concimazione, rinvaso, pulizia delle foglie. È facile dimenticare quando si è annaffiata l'ultima volta una pianta specifica, soprattutto quando ne hai diverse.

Le app esistenti come Planta, Blossom, e PictureThis sono freemium: le feature più utili sono dietro paywall (€25-30/anno), richiedono account, e i tuoi dati restano sui loro server.

## Cosa Fa Linfa

1. **Registra le tue piante** con foto, nome, specie, e posizione
2. **Imposta promemoria personalizzati** per ogni pianta (annaffiare, concimare, rinvasare, pulire)
3. **Traccia la crescita** con foto periodiche e note
4. **Notifiche locali** - nessun server necessario, tutto resta sul tuo dispositivo
5. **Esporta i tuoi dati** in qualsiasi momento - nessun lock-in

## Filosofia

- **100% gratuita** - niente paywall, niente abbonamenti
- **Open source** - il codice è trasparente, chiunque può contribuire
- **Privacy-first** - tutti i dati restano sul dispositivo, nessun account richiesto
- **Offline-first** - funziona senza connessione internet
- **Semplice** - fa una cosa sola e la fa bene

## Funzionalità

### Core
- Aggiunta piante con foto e informazioni base
- Promemoria personalizzabili per ogni pianta
- Notifiche locali push
- Timeline di crescita con foto
- Note e osservazioni per ogni pianta

### Organizzazione
- Raggruppamento per stanza o posizione
- Filtri per tipo di pianta
- Ricerca per nome
- Ordinamento per ultimo controllo o nome

### Export
- Esportazione dati in JSON
- Esportazione foto in galleria
- Backup manuale su cloud personale

### Personalizzazione
- Icone per tipo di promemoria
- Colori per stato della pianta
- Suoni di notifica personalizzabili
- Tema chiaro/scuro

## Stack Tecnologico

### Perché Flutter?

Flutter è stato scelto come framework principale per la sua capacità di compilare nativamente su **6 piattaforme** da un singolo codebase:

| Piattaforma | Supporto | Note |
|-------------|----------|------|
| **Android** | ✅ Stabile | Play Store ready |
| **iOS** | ✅ Stabile | App Store ready |
| **Web** | ✅ Stabile | PWA support |
| **macOS** | ✅ Stabile | Apple Silicon + Intel |
| **Windows** | ✅ Stabile | Win10+ |
| **Linux** | ✅ Stabile | GTK backend |

**Vantaggi per Linfa:**
- **Offline-first nativo** - nessun server richiesto, tutti i dati restano sul dispositivo
- **Performance native** - compilazione AOT, nessun bridge JavaScript
- **Material 3 integrato** - UI moderna e coerente su tutte le piattaforme
- **Ecosistema maturo** - pacchetti ufficiali per notifiche, camera, storage locale
- **Time-to-market veloce** - hot reload, testing integrato, CI/CD semplificato

### Core Framework
- **Flutter 3.x** - Framework cross-platform di Google
- **Dart 3.x** - Linguaggio principale con pattern matching e records
- **Riverpod** - State management moderno e type-safe
- **go_router** - Navigazione dichiarativa con deep linking
- **flutter_local_notifications** - Notifiche locali senza server

### Storage
- **Isar** - Database NoSQL locale, veloce e type-safe
- **Hive** - Key-value storage per preferenze utente
- **image_picker** - Accesso alla camera e galleria
- **path_provider** - Gestione percorsi file cross-platform

### UI/UX
- **Material 3** - Design system moderno di Google
- **flutter_animate** - Animazioni fluide e dichiarative
- **Custom Painter** - Grafici e visualizzazioni custom
- **responsive_framework** - Adattamento a tablet e foldable
- **google_fonts** - Tipografia coerente

### Testing & CI/CD
- **flutter_test** - Testing framework ufficiale
- **mockito** - Mocking per unit test
- **integration_test** - E2E testing su dispositivi reali
- **GitHub Actions** - CI/CD per build e test automatici
- **Fastlane** - Automazione release per App Store e Play Store

### Quality & Linting
- **very_good_analysis** - Linting rigoroso
- **sonarqube** - Analisi qualità codice
- **codecov** - Coverage reporting

## Struttura del Progetto

```
linfa/
├── lib/
│   ├── main.dart                    # Entry point
│   ├── app.dart                     # Configurazione app
│   ├── core/
│   │   ├── constants/
│   │   │   ├── colors.dart          # Palette colori
│   │   │   ├── strings.dart         # Stringhe localizzate
│   │   │   └── routes.dart          # Definizione rotte
│   │   ├── theme/
│   │   │   ├── light.dart           # Tema chiaro
│   │   │   ├── dark.dart            # Tema scuro
│   │   │   └── typography.dart      # Tipografia
│   │   └── utils/
│   │       ├── date.dart            # Utility date
│   │       ├── image.dart           # Utility immagini
│   │       └── export.dart          # Export dati
│   ├── data/
│   │   ├── models/
│   │   │   ├── plant.dart           # Modello pianta
│   │   │   ├── reminder.dart        # Modello promemoria
│   │   │   ├── growth_entry.dart    # Modello entry crescita
│   │   │   └── plant_type.dart      # Tipi di pianta predefiniti
│   │   ├── repositories/
│   │   │   ├── plant_repository.dart # CRUD piante
│   │   │   └── reminder_repository.dart # CRUD promemoria
│   │   └── database/
│   │       ├── database.dart        # Setup Isar
│   │       └── migrations.dart      # Migrazioni DB
│   ├── features/
│   │   ├── home/
│   │   │   ├── home_screen.dart     # Dashboard principale
│   │   │   └── widgets/
│   │   │       ├── plant_card.dart  # Card pianta
│   │   │       └── upcoming_reminders.dart # Promemoria imminenti
│   │   ├── plants/
│   │   │   ├── plant_list_screen.dart
│   │   │   ├── plant_detail_screen.dart
│   │   │   ├── add_plant_screen.dart
│   │   │   └── edit_plant_screen.dart
│   │   ├── reminders/
│   │   │   ├── reminder_list_screen.dart
│   │   │   ├── add_reminder_screen.dart
│   │   │   └── widgets/
│   │   │       └── reminder_card.dart
│   │   ├── growth/
│   │   │   ├── growth_timeline_screen.dart
│   │   │   └── widgets/
│   │   │       └── growth_photo_card.dart
│   │   └── settings/
│   │       ├── settings_screen.dart
│   │       └── widgets/
│   │           └── export_data_button.dart
│   └── shared/
│       ├── widgets/
│       │   ├── empty_state.dart     # Stato vuoto riutilizzabile
│       │   ├── photo_picker.dart    # Picker foto
│       │   └── reminder_picker.dart # Selettore orario
│       └── providers/
│           ├── theme_provider.dart  # Provider tema
│           └── notification_provider.dart # Provider notifiche
├── assets/
│   ├── images/                      # Immagini statiche
│   ├── icons/                       # Icone custom
│   └── plant_types/                 # Database tipi piante
│       └── plant_types.json
├── test/
│   ├── unit/
│   │   ├── models/
│   │   ├── repositories/
│   │   └── utils/
│   ├── widget/
│   │   ├── home_screen_test.dart
│   │   └── plant_card_test.dart
│   └── integration/
│       └── app_test.dart
├── integration_test/
│   └── full_flow_test.dart
├── android/                         # Configurazione Android
├── ios/                             # Configurazione iOS
├── pubspec.yaml                     # Dipendenze Flutter
├── analysis_options.yaml            # Configurazione linting
└── .github/
    └── workflows/
        ├── ci.yml                   # CI per test e lint
        └── release.yml              # Build release automatici
```

## Quick Start

### Prerequisiti

- Flutter 3.x installato
- Android Studio o Xcode per emulatori
- Un dispositivo fisico per testare le notifiche locali

### Installazione

```bash
# Clona il repository
git clone https://github.com/cataWalter/linfa.git
cd linfa

# Installa dipendenze
flutter pub get

# Avvia l'app
flutter run
```

### Build per Produzione

```bash
# Build Android
flutter build apk --release

# Build iOS
flutter build ios --release
```

## Utilizzo

1. **Aggiungi la tua prima pianta**: Click sul +, scatta una foto, inserisci nome e specie
2. **Imposta promemoria**: Dalla scheda della pianta, aggiungi promemoria per annaffiare, concimare, ecc.
3. **Ricevi notifiche**: L'app ti ricorderà quando è ora di curare le tue piante
4. **Traccia la crescita**: Aggiungi foto periodiche per vedere come cambia nel tempo
5. **Esporta i dati**: Dalle impostazioni, esporta tutto in JSON per backup

## Tipi di Piante Predefiniti

Linfa include un database base di piante comuni con cure consigliate:

| Pianta | Annaffiatura | Luce | Note |
|--------|-------------|------|------|
| Pothos | Ogni 7-10 giorni | Indiretta | Molto resistente |
| Monstera | Ogni 7 giorni | Indiretta brillante | Ama l'umidità |
| Sansevieria | Ogni 14-21 giorni | Qualsiasi | Quasi indistruttibile |
| Ficus | Ogni 7-10 giorni | Indiretta brillante | Sensibile ai cambiamenti |
| Succulente | Ogni 14-21 giorni | Diretta | Poco acqua |
| Felce | Ogni 3-5 giorni | Indiretta | Ama l'umidità |

## Roadmap

- [ ] Database più completo di piante con cure specifiche
- [ ] Widget home screen per promemoria rapidi
- [ ] Condivisione piante con QR code
- [ ] Integrazione con meteo locale per suggerimenti
- [ ] Modalità "vacanza" per pause prolungate
- [ ] Supporto tablet e foldable ottimizzato
- [ ] Localizzazione in 10+ lingue
- [ ] Accessibilità completa (VoiceOver, TalkBack)

## Sviluppo

### Aggiungere un Nuovo Tipo di Pianta

Modifica `assets/plant_types/plant_types.json`:

```json
{
  "name": "Nome Pianta",
  "scientific_name": "Nome Scientifico",
  "watering_frequency_days": 7,
  "light_requirements": "indirect_bright",
  "humidity_level": "medium",
  "difficulty": "easy",
  "tips": ["Consiglio 1", "Consiglio 2"]
}
```

### Testing

```bash
# Unit test
flutter test

# Widget test
flutter test test/widget/

# Integration test
flutter test integration_test/

# Coverage
flutter test --coverage
```

### Linting

```bash
# Analisi statica
flutter analyze

# Formattazione
dart format lib/
```

## Contributing

Le contribuzioni sono benvenute! Ecco come puoi aiutare:

- **Aggiungere tipi di piante** al database
- **Migliorare l'UI/UX** con feedback reali
- **Tradurre** in altre lingue
- **Testare** su diversi dispositivi
- **Segnalare bug** o suggerire feature

Leggi le linee guida per contribuire e apri una issue per discussioni.

## License

MIT License - vedi file LICENSE per dettagli.

## Ringraziamenti

- Icone da [Lucide](https://lucide.dev/)
- Font da [Google Fonts](https://fonts.google.com/)
- Ispirazione dalla community r/houseplants

https://gitlab.com/fdroid/rfp/-/work_items/3744