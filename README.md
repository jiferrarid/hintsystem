# 🎯 Hint System – Garry's Mod Addon

A modular hint system for Garry’s Mod, designed to display visual guidance and helper messages to players. The system follows an **Object-Oriented Programming (OOP)** approach and uses a **Publisher/Subscriber (PubSub)** architecture.

---

## 🧠 Architecture

This system consists of three main classes:

- **Publisher** (server-side): Sends out hint messages to specific players or all clients.
- **Subscriber** (client-side): Receives hint messages and passes them to the View.
- **View** (client-side): Renders the hint UI on the screen.

All interactions flow through these layers to keep responsibilities clear and modular.

---

## 📐 Object-Oriented Design

Each class encapsulates its own logic:

- `PublisherHint` handles network broadcasting.
- `SubscriberHint` listens to the network and manages local state.
- `ViewHint` is concerned only with visual output and timing.

This modularity allows for easy testing and future extension (e.g., localization, persistence, or sound effects).

---

## 🚦 Event Flow

1. **Server** calls `HINTSYSTEM_PUBLISHER:showHint(...)`.
2. Hint data is sent via net message to the target client(s).
3. **Client** receives data and calls `HINTSYSTEM_SUBSCRIBER:setHint(...)`.
4. Hint is passed to the `View` and shown to the player.

---

## ⚙️ Usage

### 🔹 Server Side

```lua
HINTSYSTEM_PUBLISHER:showHint("Danger Zone", "Leave this area within 10 seconds!", 8, player, false)
```

#### Parameters:
- `title` *(string)* – Short title for the hint.
- `description` *(string)* – Informative text to show.
- `duration` *(number)* – Duration (in seconds) the hint should remain.
- `player` *(Player)* – Target player or group of playres to receive the hint. If nil, then the hint is shown to everyone
- `showIfAlreadyShown` *(boolean)* – If `true`, repeats the hint even if it was already shown. If nil, then the hint is not repeated

---

### 🔸 Client Side

```lua
HINTSYSTEM_SUBSCRIBER:setHint("Objective", "Collect all the batteries before proceeding.", 10, true)
```

#### Parameters:
- `title` *(string)* – Title shown to the player.
- `description` *(string)* – Description of the hint.
- `duration` *(number)* – Time in seconds.
- `showIfAlreadyShown` *(boolean)* – Prevents duplicate hints unless forced. If nil, then the hint is not repeated

---

## 🔧 Customization

You can modify the visual behavior by editing `ViewHint.lua`:

- Change font size or color
- Add icon support or animated transitions
- Integrate with your HUD framework

---

## 📦 Installation

1. Drop the folder into your `garrysmod/addons/` directory.
2. Use `showHint()` and `setHint()` as described.

---

## 🧑‍💻 Author

Developed by **Juan Ignacio Ferrari**  
Community: [Garry's Mod Argentina](https://discord.gg/MrdD3xQ5uG)  
Freelance Developer on [GmodStore](https://www.gmodstore.com/community/threads/3PonPpdZSX6YZcpQZZUI9A)