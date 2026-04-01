# 🎨 UI Generation PRD for Google Stitch
# Smart Agriculture App v2.0

> This document is specifically formatted as a prompt/specification for **Google Stitch** (or similar AI UI generation tools). It describes the exact visual layout, components, and styling required for every screen in the Flutter application.

---

## 🎨 Global UI/UX Design System

Use these styles globally across all generated screens:

*   **Theme Vibe:** Modern, elegant, clean, "Agri-Tech". Use subtle shadows, generous whitespace, and rounded corners.
*   **Primary Accent Color:** Vibrant Green (`#22C55E`).
*   **Background Color:** Light Gray (`#F9FAFB`).
*   **Card/Surface Color:** Pure White (`#FFFFFF`) with 12px-16px border radii and a very soft drop shadow (blur 12, opacity 6%).
*   **Text Colors:** Dark Gray/Black (`#111827`) for primary text, Medium Gray (`#6B7280`) for subtitles/secondary text.
*   **Typography:** 'Inter' font family. Clean sans-serif. Headings are bold, body is regular.
*   **Buttons:** Fully rounded (pill shape) for primary actions. Solid green background, white text.
*   **Glassmorphism:** Use frosted glass overlays for hero elements (semi-transparent white background with background blur).
*   **Bottom Navigation Bar:** White background, thin grey top border. 4 icons: Home, Fields, Alerts, Profile. Active tab icon is Green, inactive is Gray.

---

## 📱 Screen Inventory & Component Breakdown

Generate the following screens based on their component hierarchies:

### 1. Splash Screen
**Layout Setup:** Full screen centered layout. Background is solid Primary Green (`#22C55E`).
**Components:**
1.  **Center Image:** App Logo (a modern leaf/tech icon) in white.
2.  **App Title:** "SmartAgri" in large, bold, white typography.
3.  **Loading Indicator:** A small white circular spinner at the bottom center.

---

### 2. Onboarding Screen
**Layout Setup:** Full screen layout with a dominant top graphic and bottom content area.
**Components:**
1.  **Top Graphic:** Large colorful illustration of a smart farm (takes up top 50% of screen).
2.  **Dots Indicator:** 3 dots indicating carousel position (one active green, two inactive gray).
3.  **Title Text:** "Monitor Your Fields 24/7" (Bold, 24px, centered).
4.  **Subtitle Text:** "Get real-time insights on soil moisture, temperature, and crop health directly on your phone." (Regular, 16px, gray, centered).
5.  **Bottom Nav Row:**
    *   Left: "Skip" text button (gray).
    *   Right: Primary Green "Next" button (pill-shaped).

---

### 3. Login Screen
**Layout Setup:** Scrollable column with a top-heavy layout. Background `#F9FAFB`.
**Components:**
1.  **Header:** Top left aligned "Welcome Back 👋" large bold text. Subtitle "Sign in to manage your fields".
2.  **Email Input:** Input field with label "Email Address", placeholder "farmer@example.com", and a mail icon prefix. Rounded grey border.
3.  **Password Input:** Input field with label "Password", placeholder "••••••••", lock icon prefix, and an eye icon suffix.
4.  **Row:**
    *   Left: Checkbox + "Remember me" text.
    *   Right: "Forgot Password?" text link (green).
5.  **Primary Button:** Full-width green button "Sign In".
6.  **Footer Row:** "Don't have an account?" (gray text) alongside "Sign Up" (green bold text).

---

### 4. Main Dashboard Screen (Home Tab)
**Layout Setup:** Scrollable vertical list. Contains a header, horizontal carousels, and vertical sections.
**Components:**
1.  **Header Row:**
    *   Left: Avatar image (circular) with greeting text next to it: "Good morning, Ahmed!".
    *   Right: Notification bell icon with a small red badge.
2.  **Stats Carousel (Horizontal Scroll):**
    *   4 squarish cards (width ~140px).
    *   Card 1: Green background. Icon 🌾, Text "Total Fields", Large Number "4".
    *   Card 2: White background. Icon 📡, Text "Active Sensors", Large Number "12" (bold green).
    *   Card 3: White background. Icon 💧, Text "Water Saved", Large Number "1,200L".
3.  **Live Sensor Hero Card:**
    *   Large featured card with a subtle gradient or glassmorphism effect.
    *   Header: "Main Wheat Field" + "● Live" green pulsing indicator.
    *   Grid of 3 items inside card:
        *   Item 1: 🌱 42% (Soil Moisture)
        *   Item 2: 🌡️ 30°C (Temp)
        *   Item 3: 💧 60% (Humidity)
    *   Footer of card: "Last updated: just now".
4.  **Quick Actions Grid:**
    *   4 square buttons in a 2x2 or 4x1 row. Icons: ➕ "Add Field", 💧 "Irrigate", 📊 "Analytics", 🤖 "AI Advice".
5.  **Recent Activity Section:**
    *   Section Title: "Recent Activity".
    *   List items: Small circular icon (e.g., green checkmark), Title "Irrigation completed", Subtitle "Main Wheat Field", Trailing text "2m ago".

---

### 5. Fields List Screen (Fields Tab)
**Layout Setup:** Standard page with App Bar and a List/Grid body.
**Components:**
1.  **App Bar:** Title "My Fields". Right action icon (Filter/Sort). Search bar below the title.
2.  **Empty State (Variation):** Illustration of an empty farm, text "No fields added yet", and a large green button "Add Your First Field".
3.  **Field Card (List Item):**
    *   Full-width card, white background, shadow.
    *   Top Row: Field Name "River Side Plot" (bold) + Area tag "10 Acres" (gray background chip).
    *   Middle Row: Crop icon 🌾 + "Wheat".
    *   Bottom Row: Small progress bar for Soil Moisture (label "Moisture 45%").
    *   Right side: Vertical three-dot menu icon.
4.  **Floating Action Button (FAB):** Green circle with white "+" icon in bottom right.

---

### 6. Field Detail Screen
**Layout Setup:** Header with field info, followed by a sliding Tabs component.
**Components:**
1.  **Hero Header:** Large card at the top. Shows Field Name, "Active" green badge, Location text, and Area text.
2.  **Tab Bar:** Row of 3 tabs: "Overview", "Sensors", "Irrigation". ("Overview" is active, styled with green underline).
3.  **Active Tab Content (Overview):**
    *   Section: Current Crop (Text: Wheat) and Planting Date (Text: Jan 10, 2026).
    *   Section: Current Conditions (Row of 3 small square cards: Temp 28°C, Humidity 55%, Soil 30%).
4.  **Active Tab Content (Irrigation):** (If User switches Tab)
    *   Large Card: "Pump Status: OFF" with a prominent grey button.
    *   Green Primary Button: "Start Irrigation Manually".
    *   List: "Upcoming Schedules" with time entries.

---

### 7. Add New Field Screen
**Layout Setup:** Form layout inside a scrollable view.
**Components:**
1.  **App Bar:** Title "Add New Field", Back button.
2.  **Form Input 1:** TextInput "Field Name" (e.g., "North Farm").
3.  **Row (2 Inputs):** TextInput "Area Size" (e.g., "15") and Dropdown "Unit" (e.g., "Acres").
4.  **Dropdown:** "Crop Type" (e.g., "Cotton").
5.  **Dropdown:** "Soil Type" (e.g., "Loamy").
6.  **Form Input 2:** DatePicker field "Planting Date" (shows calendar icon).
7.  **Map Placeholder (Optional):** A grey rectangle representing a Google Map snippet to pick location.
8.  **Footer Button:** Fixed at bottom "Save Field" (Primary green, full width).

---

### 8. Irrigation Control Panel Screen
**Layout Setup:** Focused control screen.
**Components:**
1.  **App Bar:** Title "Irrigation Control".
2.  **Field Selector Dropdown:** Large dropdown at the top to select which field to control.
3.  **Status Visualizer (Center piece):**
    *   Large circular UI element. Inside: Blue water drop icon.
    *   Text below circle: "Pump is OFF".
    *   Duration text: "Last ran for 45 mins".
4.  **Action Buttons Row:**
    *   Huge Green Pill Button: "START PUMP".
5.  **Auto-Irrigation Settings Card:**
    *   Card background: White.
    *   Row: Text "Smart Auto-Irrigation" + Toggle/Switch (Turned ON - green).
    *   Slider control below: "Trigger when soil is below 30%".
6.  **Recent Logs Section:**
    *   List of past irrigations showing Date, Duration, and Water Used.

---

### 9. Alerts & Notifications Screen (Alerts Tab)
**Layout Setup:** List view.
**Components:**
1.  **App Bar:** Title "Alerts". "Mark all as read" text button on the right.
2.  **Filter Chips Row:** Horizontal scrollable chips: "All", "Unread", "Critical", "Resolved".
3.  **Red Alert Card (Critical):**
    *   Left border is solid red (indicator).
    *   Icon: Red warning triangle ⚠️.
    *   Title: "Low Soil Moisture" (Bold).
    *   Message: "Moisture at 15% in Main Wheat Field. Immediate irrigation recommended."
    *   Time: "Just now".
    *   Buttons: "Mark Read" (outlined), "Resolve" (solid gray).
4.  **Blue Alert Card (Info):**
    *   Left border is blue.
    *   Icon: Blue info circle format ℹ️.
    *   Title: "Irrigation Completed".
    *   Message: "Pump ran for 45 mins on East Sector."

---

### 10. AI Crop Recommendations Screen
**Layout Setup:** List of detailed cards.
**Components:**
1.  **App Bar:** Title "AI Recommendations".
2.  **Recommendation Hero Card:**
    *   White card with green glowing accents.
    *   Top Row: Confidence Score Badge (e.g., "85% Match" in light green).
    *   Title: Recommended Crop "Soybeans".
    *   List of Reason bullets: "Matches Loamy soil", "Optimal for current temperature trends", "Low water requirement".
    *   Stats Row: Expected Yield "500kg/acre", Duration "90 Days".
    *   Button: Primary Green "Accept Recommendation".

---

### 11. User Profile Screen (Profile Tab)
**Layout Setup:** Standard settings/profile layout.
**Components:**
1.  **Profile Header:**
    *   Large circular Avatar Image in center.
    *   Text: "Ahmed Ali" (Bold, 20px).
    *   Text: "farmer@app.com" (Gray, 14px).
    *   Small badge: "Premium Farmer".
2.  **Menu List Group 1 (Account):**
    *   Item: Edit Profile (Arrow right icon).
    *   Item: Notification Settings.
    *   Item: App Preferences (Language/Theme).
3.  **Menu List Group 2 (Support):**
    *   Item: Help & Support.
    *   Item: Privacy Policy.
4.  **Logout Button:** Text button, Red color, center aligned at the bottom: "Log Out".

---

## 🛠️ Instructions for the Stitch / UI Generator
1.  **Maintain Consistency:** Use the exact same green `#22C55E` across all active states, primary buttons, and active tabs.
2.  **Spacing:** Ensure standard 16px padding on the left/right edges of all screens. Space between cards should be 12px.
3.  **Icons:** Use modern, filled icons for active states, outlines for inactive. Material Symbols or standard generic UI icons are fine.
4.  **Data:** Use the placeholder data provided in these descriptions, as it makes the agricultural context clear.
