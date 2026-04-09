import React from "react";
import { Outlet, useLocation, useNavigate, NavLink } from "react-router-dom";

export default function AppLayout() {
  const location = useLocation();
  const navigate = useNavigate();

  // Dynamic header title based on URL
  const getHeaderTitle = () => {
    switch (location.pathname) {
      case "/":
        return "Dashboard";
      case "/decks":
        return "Your Deck Library";
      case "/leaderboard":
        return "Global Rankings";
      case "/research":
        return "Researcher Portal";
      case "/survey":
        return "Experience Survey";
      case "/account":
        return "Your Account";
      default:
        return "BooMondai";
    }
  };

  return (
    <div className="bg-[#F8F9FA] text-gray-900 font-sans h-screen w-full overflow-hidden flex relative">
      {/* DESKTOP SIDEBAR */}
      <aside className="hidden md:flex flex-col w-64 bg-white border-r border-gray-200 h-full z-20">
        <div
          className="p-6 flex items-center gap-3 cursor-pointer"
          onClick={() => navigate("/")}
        >
          <div className="w-10 h-10 rounded-xl bg-indigo-500 shadow-[0_4px_0_0_#3F498A] flex items-center justify-center text-white text-xl">
            <i className="fa-solid fa-ghost"></i>
          </div>
          <h1 className="text-2xl font-extrabold tracking-tight text-indigo-500">
            BooMondai
          </h1>
        </div>
        <nav className="flex-1 px-4 space-y-2 mt-4">
          <SidebarLink to="/" icon="fa-house" label="Home" />
          <SidebarLink to="/decks" icon="fa-layer-group" label="Decks" />
          <SidebarLink to="/leaderboard" icon="fa-trophy" label="Leaderboard" />
          <SidebarLink to="/research" icon="fa-chart-line" label="Research" />
          <SidebarLink to="/survey" icon="fa-clipboard-list" label="Survey" />
        </nav>
        <div className="p-4 border-t border-gray-200">
          <NavLink
            to="/account"
            className={({ isActive }) =>
              `flex items-center gap-3 p-2 rounded-xl transition-colors ${isActive ? "bg-indigo-50 border-2 border-indigo-100" : "hover:bg-gray-100 border-2 border-transparent"}`
            }
          >
            <div className="w-10 h-10 rounded-full bg-gray-200 flex items-center justify-center font-bold text-gray-600 border-2 border-white shadow-sm">
              AL
            </div>
            <div className="flex-1">
              <p className="text-sm font-bold leading-tight">Alex Learner</p>
              <p className="text-xs text-gray-500 font-medium">Free Plan</p>
            </div>
            <i className="fa-solid fa-gear text-gray-400"></i>
          </NavLink>
        </div>
      </aside>

      {/* MAIN CONTENT AREA */}
      <div className="flex-1 flex flex-col h-full relative overflow-hidden">
        {/* HEADER */}
        <header className="sticky top-0 z-10 bg-[#F8F9FA]/80 backdrop-blur-md px-6 py-4 flex items-center justify-between border-b border-gray-200/50">
          <div className="md:hidden flex items-center gap-2">
            <div className="w-8 h-8 rounded-lg bg-indigo-500 text-white flex items-center justify-center font-bold shadow-[0_2px_0_0_#3F498A]">
              <i className="fa-solid fa-ghost text-sm"></i>
            </div>
            <h1 className="text-xl font-extrabold text-indigo-500">
              BooMondai
            </h1>
          </div>
          <h2 className="hidden md:block text-xl font-bold text-gray-800">
            {getHeaderTitle()}
          </h2>
          <div className="flex items-center gap-4 ml-auto">
            <div
              className="flex items-center gap-2 bg-orange-100 px-3 py-1.5 rounded-full border border-orange-200 tooltip"
              title="12 Day Streak!"
            >
              <i className="fa-solid fa-fire text-[#FFC107]"></i>
              <span className="font-bold text-orange-600 text-sm">12</span>
            </div>
          </div>
        </header>

        {/* PAGE CONTENT RENDERED HERE */}
        <main className="flex-1 overflow-y-auto pb-24 md:pb-0">
          <Outlet />
        </main>

        {/* MOBILE BOTTOM NAV */}
        <nav className="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 z-50 px-6 py-3 flex justify-between items-center pb-safe shadow-[0_-4px_20px_rgba(0,0,0,0.05)]">
          <MobileNavLink to="/" icon="fa-house" label="Home" />
          <MobileNavLink to="/decks" icon="fa-layer-group" label="Decks" />
          <button
            onClick={() => navigate("/study")}
            className="active:translate-y-1 active:shadow-none transition-all w-14 h-14 rounded-full bg-indigo-500 text-white shadow-[0_4px_0_0_#3F498A] flex items-center justify-center text-2xl -mt-8 border-4 border-white"
          >
            <i className="fa-solid fa-play ml-1"></i>
          </button>
          <MobileNavLink to="/leaderboard" icon="fa-trophy" label="Rank" />
          <MobileNavLink to="/account" icon="fa-user" label="Profile" />
        </nav>
      </div>
    </div>
  );
}

// --- NavLink Helpers ---
// React Router's <NavLink> gives us an `isActive` boolean automatically!
function SidebarLink({
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
        `w-full flex items-center gap-4 px-4 py-3 rounded-xl transition-colors ${isActive ? "bg-indigo-50 text-indigo-500 font-bold border-2 border-indigo-500/10" : "text-gray-500 font-semibold hover:bg-gray-100 border-2 border-transparent"}`
      }
    >
      <i className={`fa-solid ${icon} text-lg w-6`}></i> {label}
    </NavLink>
  );
}

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
