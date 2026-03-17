# Product Guidelines: Chazos

## 1. Visual Aesthetic: Retro-TUI
- **Color Palette:** High-contrast terminal colors. Primary focus on greens, ambers, or cyans on a dark background to mimic vintage CRT monitors.
- **ASCII Art:** Use ASCII art for banners, logos, and section separators. Prefer blocky or stylized fonts that are readable in a monospace environment.
- **Animations:** Implement simple, non-distracting text-based animations for transitions, loading states, and "alive" indicators (e.g., pulsing cursors, scrolling text).
- **Typography:** Strictly monospace. Use font weights and colors to establish hierarchy.

## 2. User Experience (UX): Keyboard-Centric
- **Modal Navigation:** Prioritize modes (like Vim or Zellij) for different contexts (e.g., navigation mode, editing mode, system mode).
- **Immediate Feedback:** Every keypress or command should provide immediate visual feedback, even if it's just a small character animation.
- **TUI-First:** If a task can be accomplished in a TUI, it must be. Graphical tools are a last resort and should be styled to blend in as much as possible.
- **Discoverability:** Include easily accessible help screens or command palettes (e.g., via `fzf` or custom TUI overlays).

## 3. Communication Style: Retro-Technical
- **Tone:** Professional yet nostalgic. Use terms like "Terminal," "Module," "Link," and "Node" to evoke a sense of vintage computing.
- **Instructions:** Clear and concise. Favor command-line examples and TUI-based walkthroughs.
- **Feedback Messages:** Use stylized error and success messages, potentially accompanied by ASCII icons.

## 4. Development Standards: Package-First
- **Configuration as Code:** All configurations must be versioned and bundled into the `chazos-config` package.
- **Atomic Changes:** Updates to the system's look or behavior should be atomic and verifiable through the package management system.
- **Testing Requirements:** Every custom TUI tool or system script must have associated tests (linting and functional validation).
- **Documentation:** Documentation should be provided in Markdown, optimized for viewing in a terminal-based pager (like `bat` or `less`).
