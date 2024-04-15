# Directory structure

The project hierarchy is described here.

- 📂 `assets` – directory containing configuration files throught the app; images, terms
- 📂 `docs` – project documentation
- 📂 `lib` – source codes

All sources are present in the 📂 `lib` folder It has the following structure by clean architecture

📂 `core`

- 📂 `constants` – global constants.
- 📂 `errors` – dealing with exceptions and erros
- 📂 `network` – checking the environment has internet connections
- 📂 `params` – defined parameters
- 📂 `util` – utility functions to set permissions, logging, etc.

📂 `features`

- 📂 `domain`

  - 📂 `entities` – defined data from the api such as each category, information of locations
  - 📂 `repositories` – abstract classes of business logic
  - 📂 `usecases` – encapulated business logics

- 📂 `data`

  - 📂 `models` – handling entities(raw data) into Dart objects
  - 📂 `repositories` – implementations domain repositories
  - 📂 `datasources` – getting remote api data and caching it for local

- 📂 `presentation`

  - 📂 `layout` – contained the common UI which applied for all screens
  - 📂 `providers` – state management collection, [provider](https://pub.dev/packages/provider) used
  - 📂 `screens` – page-like UI that consists of widgets such as home, each category screen
  - 📂 `widget` – elements of UI like item-card, bottom navigation bar

- 📂 `route` – router managed by [go_router](https://pub.dev/packages/go_router)
