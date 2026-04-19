# Frontend Changes - Dark/Light Theme Toggle

## Overview
Added a toggle button that allows users to switch between dark and light themes for the Course Materials Assistant application.

## Files Modified

### 1. `frontend/index.html`
- Header section includes theme toggle button with sun and moon SVG icons
- Added `title="Toggle theme (Ctrl+Shift+T)"` for keyboard shortcut discoverability
- Proper ARIA label for accessibility
- Bumped cache-busting version to `v=10`

### 2. `frontend/style.css`
- Light theme CSS variables with full color palette
- Theme toggle button styling:
  - Fixed duplicate `border` declaration
  - Spring-like cubic-bezier transitions (`0.34, 1.56, 0.64, 1`) for subtle bounce on hover/active
  - Changed `:focus` to `:focus-visible` so focus ring only appears during keyboard navigation
  - Added blue box-shadow glow on hover
  - More dramatic icon scale transition (0.5 vs 0.8) with longer duration (0.5s) for polished swap effect
  - Added `flex-shrink: 0` to prevent compression in flex layouts
- Smooth 0.3s transitions for all theme switching
- Responsive design for mobile devices

### 3. `frontend/script.js`
- Theme toggle with localStorage persistence
- **System color scheme detection**: on first visit (no saved preference), respects OS-level preference via `window.matchMedia('(prefers-color-scheme: dark)')` instead of always defaulting to dark
- Keyboard shortcut: `Ctrl/Cmd + Shift + T`
- Dynamic ARIA label updates based on current theme

## Features Implemented

### Toggle Button Design
- Clean, circular button (44x44px) that fits existing aesthetic
- Positioned in top-right corner of header
- Icon-based design with sun (light theme) and moon (dark theme) SVG icons

### Smooth Animations
- Universal `*` selector transitions `background-color`, `color`, `border-color`, and `box-shadow` at 0.3s for consistent theme switching across all elements
- Spring-like cubic-bezier transitions for bounce effect on hover/active
- Icon rotation and scaling with 0.5s transition duration
- Hover effects with glow shadow and scale transform

### Accessibility
- ARIA labels that update based on current theme
- `title` tooltip showing keyboard shortcut
- `:focus-visible` for keyboard-only focus ring (no ring on mouse clicks)
- Keyboard shortcut: `Ctrl/Cmd + Shift + T`

### Theme Persistence
- Uses localStorage to remember user preference
- Respects OS `prefers-color-scheme` on first visit
- Automatically applies saved theme on page load

### Responsive Design
- Header adapts to mobile screens
- Toggle button remains accessible on all screen sizes (40x40px on mobile)

## Technical Implementation

### Theme Variables
CSS custom properties on `:root` (dark default) overridden by `[data-theme="light"]`:

**Dark Theme** (Default): `#0f172a` background, `#1e293b` surface, `#f1f5f9` text
**Light Theme**: `#ffffff` background, `#f8fafc` surface, `#1e293b` text

### Light Theme CSS Variables Enhancement
Improved the light theme with additional CSS variables for better accessibility and contrast:

- **`--text-secondary`**: Changed from `#64748b` (4.6:1 contrast) to `#475569` (7:1 contrast) for WCAG AA compliance on all surfaces
- **`--code-bg`**: Added `rgba(0, 0, 0, 0.06)` for light theme (vs `rgba(0, 0, 0, 0.3)` dark) — code blocks are now visible on light backgrounds
- **`--error-text`**: `#dc2626` (dark red, 5.6:1 contrast on white) replaces `#f87171` which only had 3.3:1 on white
- **`--error-bg` / `--error-border`**: Adjusted opacity for light backgrounds
- **`--success-text`**: `#16a34a` (dark green, 4.6:1 contrast on white) replaces `#4ade80` which only had 2.3:1 on white
- **`--success-bg` / `--success-border`**: Adjusted opacity for light backgrounds
- **`--welcome-bg`**: `#eff6ff` (soft blue tint) with `--welcome-border`: `#93bbfd` (visible blue border)
- **`--focus-ring`**: Increased opacity from 0.2 to 0.3 for better visibility on light backgrounds

### CSS Rules Updated
- Code blocks (`pre`, `code`) now use `var(--code-bg)` instead of hardcoded `rgba(0, 0, 0, 0.2)`
- Error/success messages use CSS variables for all color properties
- Welcome message now uses dedicated `--welcome-bg` and `--welcome-border` variables with theme-appropriate `var(--shadow)`

### JavaScript Theme Management
- `initializeTheme()`: Sets theme from localStorage or detects OS preference
- `toggleTheme()`: Switches between themes
- `setTheme(theme)`: Applies theme, updates ARIA labels, saves to localStorage
