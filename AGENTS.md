# AI Query Widget - Agent Guidelines

## Project Overview
KDE Plasma 6 widget (plasmoid) for querying AI APIs (Google Gemini, OpenRouter) with daily caching and Markdown rendering.

## Build Commands

```bash
# Build the .plasmoid package
./build.sh

# Manual build (creates distributable package)
zip -r Ai-Query.plasmoid Ai-Query/ -x "Ai-Query/.git/*"
```

## Testing Commands

```bash
# Test with plasmawindowed (requires plasma SDK)
plasmawindowed -d Ai-Query/

# Don't need to install this code is already linked to the install directory

# Refresh for testing
kbuildsycoca6  # Refresh KDE cache
plasmashell --replace &  # Restart Plasma

# Check for QML errors
timeout 5 plasmawindowed -d Ai-Query/ 2>&1 | grep -i "error\|qml"
```

## Code Style Guidelines

### QML (UI Files)
- **Imports**: Group Qt imports first, then KDE imports
  ```qml
  import QtQuick
  import QtQuick.Controls as QQC2
  import QtQuick.Layouts
  import org.kde.plasma.plasmoid
  import org.kde.plasma.core as PlasmaCore
  import org.kde.plasma.components as PlasmaComponents
  import org.kde.kirigami as Kirigami
  ```
- **Indentation**: 4 spaces
- **Id naming**: camelCase (e.g., `configGeneral`, `root`, `apiKeyField`)
- **Property aliases**: Use `cfg_` prefix for config bindings: `property alias cfg_apiKey: apiKeyField.text`
- **Strings**: Use `i18n()` for all user-facing strings
- **Comments**: Use `//` for single-line, Italian allowed for implementation notes

### JavaScript (API Modules)
- **Location**: `contents/code/*.js`
- **Pragma**: Always include `.pragma library` at top
- **Functions**: camelCase, use callbacks for async operations
- **Error handling**: Always provide fallback error messages
- **Comments**: English for public APIs, mixed allowed for internal logic

### XML (Configuration)
- **Schema**: Follow KDE KCFG standard
- **Defaults**: Always provide sensible defaults
- **Types**: Use String, Int, Bool appropriately

### File Structure
```
Ai-Query/
├── metadata.json              # Widget metadata
├── contents/
│   ├── ui/
│   │   ├── main.qml          # Main widget UI
│   │   ├── configGeneral.qml # Settings page 1
│   │   ├── configQuery.qml   # Settings page 2
│   │   └── configAdvanced.qml # Settings page 3
│   ├── code/
│   │   ├── gemini.js         # Google API client
│   │   └── openrouter.js     # OpenRouter API client
│   └── config/
│       ├── main.xml          # Config schema
│       └── config.qml        # Config page organization
```

## Naming Conventions

- **Files**: kebab-case for directories, PascalCase for QML files, camelCase for JS
- **IDs**: camelCase (e.g., `widgetTitleField`, `geminiModelComboBox`)
- **Properties**: camelCase, descriptive names
- **Configuration keys**: camelCase in XML, accessed via `plasmoid.configuration.keyName`

## Error Handling

- Always validate API keys before making requests
- Use try/catch when parsing JSON responses
- Provide user-friendly error messages via `i18n()`
- Set timeout on XMLHttpRequest (30 seconds)
- Handle network errors with `xhr.onerror` and `xhr.ontimeout`

## Security

- Store API keys in plasmoid configuration (not in code)
- Use password echo mode for API key fields
- Never log API keys or sensitive data

## UI Patterns

- Use `Kirigami.FormLayout` for settings pages
- Use `Kirigami.Units` for spacing and sizing
- Use `Kirigami.Icon` instead of emoji (they don't render in Plasma)
- Support both compact (panel) and full (popup) representations
- Always provide tooltips for icon-only buttons

## Plasma 6 Specifics

- Root element must be `PlasmoidItem` (not `Item`)
- Use `org.kde.plasma.plasmoid` import (no version)
- Access theme via `Kirigami.Theme` (not `PlasmaCore.Theme`)
- Use `Kirigami.Units` for sizing
- Minimum API version: `"X-Plasma-API-Minimum-Version": "6.0"`

## CI/CD

GitHub Actions workflow:
- Triggers on push to main/master and version tags
- Runs `build.sh` to create package
- Uploads artifact and creates releases for tags

## References

- `.agent/skills/kde-plasma-widget-dev/SKILL.md` - Comprehensive Plasma 6 development guide
- KDE Developer Docs: https://develop.kde.org/docs/plasma/widget/
