import { BrowserRouter, Routes, Route } from "react-router-dom";

// Layouts
import AppLayout from "./layouts/AppLayout";

// Pages
import Home from "./pages/Home.tsx";
import Decks from "./pages/Decks.tsx";
import StudySession from "./pages/StudySession.tsx";
import CreatorStudio from "./pages/CreatorStudio.tsx";
import DesignSystem from "./pages/DesignSystem.tsx"; // <-- IMPORT HERE

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* GLOBAL APP SHELL */}
        <Route path="/" element={<AppLayout />}>
          <Route index element={<Home />} />
          <Route path="decks" element={<Decks />} />
        </Route>
        {/* IMMERSIVE ROUTES */}
        <Route path="/study" element={<StudySession />} />
        <Route path="/creator" element={<CreatorStudio />} />
        <Route path="/design" element={<DesignSystem />} />{" "}
        {/* <-- NEW ROUTE */}
      </Routes>
    </BrowserRouter>
  );
}
