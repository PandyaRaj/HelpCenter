# Internal Tools Dashboard (Angular + Tailwind)

A responsive Angular dashboard application styled with Tailwind CSS.

## Features

### 1. Ticket Viewer
- Display support tickets in a table format
- Filter by status: All, Open, In Progress, Closed
- Columns: ID, Subject, Status, Priority, Assignee, Created At
- Color-coded status badges
- Priority indicators
- Dummy data with 15 sample tickets

### 2. Knowledge Base Editor
- Full-featured Markdown editor
- Real-time preview pane
- Insert article templates
- Save functionality (simulated)
- Syntax highlighting for code blocks
- Support for headers, lists, links, images, tables
- Clear content option

### 3. Live Logs Panel
- Real-time log generation (every 2 seconds)
- Color-coded log levels: INFO, SUCCESS, WARNING, ERROR
- Auto-scroll functionality
- Pause/Resume log generation
- Clear logs
- Export logs to text file
- Log statistics dashboard
- Latest logs appear at top

### 4. Navigation
- Collapsible sidebar
- Smooth transitions
- Active route highlighting
- Responsive design
- Mobile-friendly

## Prerequisites

- Node.js (16.x or higher)
- npm (8.x or higher)

## Installation

```bash
cd webpage
npm install
```

## Running the Application

### Development Server

```bash
npm start
# or
ng serve --host 0.0.0.0
```

The app will be available at:
- **Local**: `http://localhost:4200`
- **Network** (for Flutter WebView): `http://0.0.0.0:4200`
- **Android Emulator**: Use `http://10.0.2.2:4200`
- **iOS Simulator**: Use `http://localhost:4200`

### Production Build

```bash
npm run build
```

## Project Structure

```
webpage/
├── src/
│   ├── app/
│   │   ├── tickets/           # Ticket viewer component
│   │   ├── knowledgebase/     # Markdown editor component  
│   │   ├── logs/              # Live logs component
│   │   ├── app.component.*    # Main app with navigation
│   │   └── app.module.ts      # Angular module with routing
│   ├── styles.css             # Global styles + Tailwind
│   ├── index.html             # HTML entry point
│   └── main.ts                # TypeScript entry point
├── angular.json               # Angular CLI configuration
├── package.json               # Dependencies
├── tailwind.config.js         # Tailwind configuration
├── tsconfig.json              # TypeScript configuration
└── README.md                  # This file
```

## Technology Stack

- **Angular**: 17.x
- **Tailwind CSS**: 3.4.x
- **TypeScript**: 5.2.x
- **Marked**: 11.x (Markdown parsing)
- **RxJS**: 7.8.x

## Key Features

### Responsive Design
- Mobile-first approach
- Breakpoints for tablet and desktop
- Collapsible sidebar on small screens
- Touch-friendly buttons

### Tailwind Styling
- Utility-first CSS
- Custom color palette
- Smooth animations
- Hover effects
- Focus states

### Real-time Updates
- Auto-refreshing logs
- Immediate preview in Markdown editor
- Live filtering in tickets

## Components

### Tickets Component
**Location**: `src/app/tickets/`

Features:
- Table display with sorting capability
- Filter buttons for status
- Color-coded status badges
- Priority indicators
- Responsive layout

### Knowledgebase Component
**Location**: `src/app/knowledgebase/`

Features:
- Side-by-side editor and preview
- Markdown syntax support
- Template insertion
- Save confirmation
- Syntax hints

### Logs Component
**Location**: `src/app/logs/`

Features:
- Real-time log generation
- Pause/Resume functionality
- Auto-scroll toggle
- Export to file
- Statistics dashboard
- Color-coded log levels

## Customization

### Colors
Edit `tailwind.config.js` to customize the color palette:

```javascript
theme: {
  extend: {
    colors: {
      primary: {
        // Your custom colors
      },
    },
  },
}
```

### Log Generation Speed
Edit `logs.component.ts`:

```typescript
this.logInterval = setInterval(() => {
  // ...
}, 2000); // Change interval (milliseconds)
```

### Dummy Data
Edit the respective component TypeScript files to modify:
- Ticket data: `tickets.component.ts`
- Log messages: `logs.component.ts`
- Markdown content: `knowledgebase.component.ts`

## Testing in Flutter WebView

### Android
```typescript
// Flutter will use: http://10.0.2.2:4200
```

### iOS
```typescript
// Flutter will use: http://localhost:4200
```

Make sure to run:
```bash
ng serve --host 0.0.0.0
```

This allows connections from external devices/emulators.

## Troubleshooting

### Port Already in Use
```bash
ng serve --host 0.0.0.0 --port 4201
```

Then update Flutter's WebView URL accordingly.

### Cannot Connect from Emulator
- Ensure `--host 0.0.0.0` flag is used
- Check firewall settings
- For Android: Use `10.0.2.2:4200`
- For iOS: Use `localhost:4200`

### Styling Not Applied
```bash
# Rebuild Tailwind
npm run build
```

### Module Not Found
```bash
npm install
```

## Performance

- Lazy loading for routes (can be added)
- Optimized bundle size
- Efficient change detection
- Minimal external dependencies

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers

## License

This project is for assessment purposes.

---

**Built with Angular 17 + Tailwind CSS 3**
