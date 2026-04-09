import { BrowserRouter, Routes, Route } from "react-router-dom";
import { SettingsProvider } from "./contexts/SettingsContext";

// Layouts
import AppLayout from "./layouts/AppLayout";

// Pages
import Home from "./pages/Home.tsx";
import Decks from "./pages/Decks.tsx";
import StudySession from "./pages/StudySession.tsx";
import CreatorStudio from "./pages/CreatorStudio.tsx";
import DesignSystem from "./pages/DesignSystem.tsx";
import Settings from "./pages/Settings.tsx";

export default function App() {
  return (
    <SettingsProvider>
      <BrowserRouter>
        <Routes>
          {/* GLOBAL APP SHELL */}
          <Route path="/" element={<AppLayout />}>
            <Route index element={<Home />} />
            <Route path="decks" element={<Decks />} />
            <Route path="settings" element={<Settings />} />
          </Route>
          {/* IMMERSIVE ROUTES */}
          <Route path="/study" element={<StudySession />} />
          <Route path="/creator" element={<CreatorStudio />} />
          <Route path="/design" element={<DesignSystem />} />
        </Routes>
      </BrowserRouter>
    </SettingsProvider>
  );
}
