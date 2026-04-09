import React from "react";
import { NavLink, useNavigate } from "react-router-dom";

// Helper component for mobile links
function MobileNavLink({
  to,
  icon,
  label,
}: {
  to: string;
  icon: string;
  label: string;
}) {
  return (
    <NavLink
      to={to}
      className={({ isActive }) =>
        `flex flex-col items-center gap-1 ${isActive ? "text-indigo-500" : "text-gray-400"}`
      }
    >
      <i className={`fa-solid ${icon} text-xl`}></i>
      <span className="text-[10px] font-bold">{label}</span>
    </NavLink>
  );
}

export default function MobileNav() {
  const navigate = useNavigate();

  return (
    <nav className="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 z-50 px-6 py-3 flex justify-between items-center pb-safe shadow-[0_-4px_20px_rgba(0,0,0,0.05)]">
      <MobileNavLink to="/" icon="fa-house" label="Home" />
      <MobileNavLink to="/decks" icon="fa-layer-group" label="Decks" />

      {/* Immersive Action Button (Study Session) */}
      <button
        onClick={() => navigate("/study")}
        className="active:translate-y-1 active:shadow-none transition-all w-14 h-14 rounded-full bg-indigo-500 text-white shadow-[0_4px_0_0_#3F498A] flex items-center justify-center text-2xl -mt-8 border-4 border-white"
      >
        <i className="fa-solid fa-play ml-1"></i>
      </button>

      <MobileNavLink to="/leaderboard" icon="fa-trophy" label="Rank" />
      <MobileNavLink to="/account" icon="fa-user" label="Profile" />
    </nav>
  );
}
