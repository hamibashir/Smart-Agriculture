# Design System Strategy: The Precision Orchard

## 1. Overview & Creative North Star
**Creative North Star: "The Digital Greenhouse"**

This design system is a rejection of the cluttered, "dashboard-heavy" legacy of agricultural software. Instead, we embrace a high-end editorial approach that mirrors the precision of modern agri-tech: clean, clinical, yet fundamentally organic. We avoid "template" layouts by utilizing intentional asymmetry—placing high-density data visualizations against expansive, breathable white space. The goal is to make the user feel they are overlooking a vast, well-managed landscape rather than staring at a spreadsheet.

## 2. Color & Surface Architecture
The palette transitions from the sterile precision of high-tech labs to the vibrant vitality of a healthy crop.

### Color Tokens (Material Convention)
*   **Primary:** `#006E2F` (Deep Forest - for authority and text)
*   **Primary Container:** `#22C55E` (Vibrant Sprout - the "pulse" of the system)
*   **Background:** `#F8F9FA` (Mist - the canvas)
*   **Surface Container Lowest:** `#FFFFFF` (Pure Light - for primary interaction cards)
*   **Outline Variant:** `#BCCBB9` (Soft Moss - for ghost boundaries)

### The "No-Line" Rule
To maintain a premium, editorial feel, **1px solid borders are strictly prohibited for sectioning.** Boundaries must be defined through background color shifts.
*   *Implementation:* A `surface-container-low` section should sit directly on a `surface` background. Let the change in value define the edge, not a stroke.

### Surface Hierarchy & Nesting
Treat the UI as a physical stack of semi-transparent layers.
*   **Base:** `background` (#F8F9FA)
*   **Level 1 (Sections):** `surface-container-low` (#F3F4F5)
*   **Level 2 (Active Cards):** `surface-container-lowest` (#FFFFFF)
This nesting creates a "soft lift" that guides the eye without cognitive load.

### The "Glass & Gradient" Rule
Standard flat colors feel static. To inject "soul," use subtle linear gradients (135°) transitioning from `primary` to `primary-container` for hero actions. For floating navigation or overlays, use **Glassmorphism**: a semi-transparent `surface` color with a `20px` backdrop-blur to allow the "greenery" of the data to bleed through.

## 3. Typography: The Editorial Voice
We use **Inter** not as a system font, but as a Swiss-style architectural tool.

*   **Display (Display-LG/MD):** These are your "Landmarks." Use bold weights with tight tracking (-0.02em). These should feel like headlines in a high-end architectural magazine.
*   **Headlines & Titles:** Always Bold. They provide the "skeleton" of the page.
*   **Body (Body-LG/MD):** Regular weight. Use generous line-height (1.6) to ensure data-heavy reports remain legible under sunlight in the field.
*   **Labels:** Use `label-md` in all-caps with increased tracking (+0.05em) for metadata to distinguish it from actionable body text.

## 4. Elevation & Depth
### The Layering Principle
Depth is achieved through **Tonal Layering**. Place a `surface-container-lowest` card on a `surface-container-low` background. This creates a natural, "biological" depth rather than a mechanical one.

### Ambient Shadows
When a card must float (e.g., a critical alert or a hover state), use the **Agri-Blur**:
*   **Blur:** 12px - 16px
*   **Opacity:** 6%
*   **Color:** Tint the shadow with `primary` (Green) rather than black. This mimics natural light filtering through a canopy.

### The "Ghost Border" Fallback
If a border is required for accessibility (e.g., input fields), use the `outline-variant` token at **20% opacity**. It should be felt, not seen.

## 5. Components
### Buttons
*   **Primary:** Fully rounded (pill shape). Use the `primary-container` (#22C55E) with `on-primary` (White) text. On hover, apply a subtle inner glow rather than a dark overlay.
*   **Secondary:** Ghost style. No background, `outline-variant` ghost border (20% opacity), text in `primary`.

### Cards & Lists
*   **Rule:** Forbid divider lines.
*   **Execution:** Separate list items using the **Spacing Scale (Step 2 or 3)**. For cards, use a `1.5rem` (md) or `2rem` (lg) border radius to soften the high-tech edge.

### Chips
*   **Filter Chips:** Use `surface-container-high` with `12px` rounding. When active, transition to `primary-container` with a subtle scale-up (1.05x) to provide a tactile, "organic" response.

### Data Inputs
*   **Fields:** Use `surface-container-lowest` (#FFFFFF) with a `0.5rem` (sm) radius. The focus state should not be a thick border, but a soft `primary` glow (ambient shadow).

## 6. Do’s and Don'ts

### Do:
*   **Do** use asymmetrical margins. If the left margin is `spacing-16`, try a right margin of `spacing-24` for a sophisticated, editorial layout.
*   **Do** use "Optical Wide-spacing." Give your data points room to breathe; white space is a functional tool for clarity.
*   **Do** use high-quality, desaturated imagery of crops/machinery to ground the high-tech UI in reality.

### Don’t:
*   **Don't** use pure black (#000000). Use `on-surface` (#191C1D) for text to keep the "Mist" vibe.
*   **Don't** use 100% opaque borders. They create "visual noise" that competes with the data.
*   **Don't** use standard "Material Design" blue for links. Everything interactive must be rooted in the `primary` green or `secondary` forest tones.