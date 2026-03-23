# Blink Test

A SwiftUI iOS chat application that displays grouped conversations and supports sending messages, with local persistence.

## Project Structure

```
Blink_test/
├── Models/
│   ├── Chat.swift               # Chat model (Codable, Identifiable)
│   └── Message.swift            # Message model (Codable, Identifiable)
├── ViewModels/
│   ├── ChatsViewModel.swift     # Manages list of chats and view state
│   └── ChatViewModel.swift      # Manages individual chat, forwards changes to parent
├── Views/
│   ├── ChatsListView.swift      # Root view showing grouped chat list
│   ├── ChatView.swift           # Individual chat view with message input
│   ├── ChatRowView.swift        # Single row in the chats list
│   └── MessageView.swift        # Single message bubble
├── Helpers/
│   └── TimeFormatter.swift      # Date formatting and message/chat grouping
├── Persistence/
│   └── PersistenceManager.swift # Local JSON read/write to Documents directory
├── Data/
│   └── conversations.json       # Bundled seed data
└── Blink_testTests/             # Unit tests
```

## Architecture

The app follows the **MVVM** pattern with a clear separation between data ownership and presentation.

### State Management

`ChatsViewModel` is the **single source of truth**. It holds all chat data inside a `ChatsViewState` enum:

```swift
public enum ChatsViewState {
    case idle
    case loading
    case data([GroupedChats])
    case error(String)
}
```

Views observe this state and render accordingly.

### ViewModel Hierarchy

`ChatsViewModel` owns the data. `ChatViewModel` holds a reference to it rather than its own copy of `Chat`, ensuring mutations made inside a conversation propagate back up to the list automatically.

```
ChatsViewModel (source of truth)
    └── ChatViewModel (window into parent data)
```

`ChatViewModel` forwards `objectWillChange` events from `ChatsViewModel` so that `ChatView` re-renders whenever the parent state changes.

### Models

Both `Chat` and `Message` are **value types** (`struct`). `Chat.messages` is declared `public private(set)` — readable from outside the module but only mutable internally via `mutating func appendMessage(_:)`.

## Persistence

On first launch, `PersistenceManager` copies `conversations.json` from the app bundle into the Documents directory. All subsequent reads and writes go through the Documents copy, so new messages are persisted across sessions.

```
First launch:  Bundle → Documents/conversations.json
Subsequent:    Read/write Documents/conversations.json directly
```

Saves use `.atomic` file writing to prevent data corruption if the app is terminated mid-write.

## Key Design Decisions

| Decision | Rationale |
|---|---|
| `viewState` enum as single source of truth | Eliminates impossible states (e.g. loading + data simultaneously) |
| `ChatViewModel` references parent rather than copying `Chat` | Mutations propagate automatically without manual syncing |
| `UUID` created on `ChatsViewModel` init | Simulates a user session for the lifetime of the app run |

## Known Limitations & Future Work

The following areas were not addressed in this implementation:

**Testing** — Unit tests for `ChatsViewModel` and `ChatViewModel` are not yet written. Additionally, `ChatsViewModel` currently lacks a protocol abstraction, which makes it impossible to inject a mock in `ChatViewModel` tests and test the two in isolation.

**UI/UX Design** — The current interface is functional but minimal. A full design pass covering typography, spacing, colour theming, and animations has not been applied.

**Message Features** — Functionality such as editing a sent message or cancelling/deleting a message has not been considered and would require changes to both the data model and persistence layer.



