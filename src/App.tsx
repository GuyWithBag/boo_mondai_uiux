import { useState } from "react";

import { CreatorStudio } from "./pages/CreatorStudio";

import StudySession from "./pages/StudySession";

import { DesignSystem } from "./pages/DesignSystem";

// --- Types ---

type RouteType = "app" | "study" | "creator" | "design";

type AppViewType =
  | "home"
  | "decks"
  | "leaderboard"
  | "research"
  | "survey"
  | "account";

// --- MAIN APP COMPONENT ---

export default function App() {
  const [route, setRoute] = useState<RouteType>("app");

  const [appView, setAppView] = useState<AppViewType>("home");

  const navigateToRoute = (newRoute: RouteType) => setRoute(newRoute);

  const switchAppView = (view: AppViewType) => {
    setAppView(view);

    setRoute("app");
  };

  return (
    <div className="bg-[#F8F9FA] text-gray-900 font-sans h-screen w-full overflow-hidden antialiased selection:bg-indigo-500 selection:text-white relative">
      {route === "app" && (
        <AppLayout
          currentView={appView}
          switchView={switchAppView}
          navigate={navigateToRoute}
        />
      )}

      {route === "study" && (
        <StudySession onClose={() => navigateToRoute("app")} />
      )}

      {route === "creator" && (
        <CreatorStudio onClose={() => navigateToRoute("app")} />
      )}

      {route === "design" && (
        <DesignSystem onClose={() => navigateToRoute("app")} />
      )}
    </div>
  );
}

// --- GLOBAL APP LAYOUT ---

export function AppLayout({
  currentView,

  switchView,

  navigate,
}: {
  currentView: AppViewType;

  switchView: (v: AppViewType) => void;

  navigate: (r: RouteType) => void;
}) {
  const titles: Record<AppViewType, string> = {
    home: "Dashboard",

    decks: "Your Deck Library",

    leaderboard: "Global Rankings",

    research: "Researcher Portal",

    survey: "Experience Survey",

    account: "Your Account",
  };

  return (
    <div className="flex h-full w-full">
      {/* Desktop Sidebar */}

      <aside className="hidden md:flex flex-col w-64 bg-white border-r border-gray-200 h-full z-20">
        <div className="p-6 flex items-center gap-3 cursor-pointer">
          <div className="w-10 h-10 rounded-xl bg-indigo-500 shadow-[0_4px_0_0_#3F498A] flex items-center justify-center text-white text-xl">
            <i className="fa-solid fa-ghost"></i>
          </div>

          <h1 className="text-2xl font-extrabold tracking-tight text-indigo-500">
            BooMondai
          </h1>
        </div>

        <nav className="flex-1 px-4 space-y-2 mt-4">
          <SidebarButton
            active={currentView === "home"}
            icon="fa-house"
            label="Home"
            onClick={() => switchView("home")}
          />

          <SidebarButton
            active={currentView === "decks"}
            icon="fa-layer-group"
            label="Decks"
            onClick={() => switchView("decks")}
          />

          <SidebarButton
            active={currentView === "leaderboard"}
            icon="fa-trophy"
            label="Leaderboard"
            onClick={() => switchView("leaderboard")}
          />

          <SidebarButton
            active={currentView === "research"}
            icon="fa-chart-line"
            label="Research"
            onClick={() => switchView("research")}
          />

          <SidebarButton
            active={currentView === "survey"}
            icon="fa-clipboard-list"
            label="Survey"
            onClick={() => switchView("survey")}
          />

          <div className="pt-4 border-t border-gray-100">
            <SidebarButton
              active={false}
              icon="fa-palette"
              label="Design System"
              onClick={() => navigate("design")}
            />
          </div>
        </nav>

        <div className="p-4 border-t border-gray-200">
          <div
            onClick={() => switchView("account")}
            className="flex items-center gap-3 p-2 rounded-xl hover:bg-gray-100 cursor-pointer transition-colors"
          >
            <div className="w-10 h-10 rounded-full bg-gray-200 flex items-center justify-center font-bold text-gray-600 border-2 border-white shadow-sm">
              AL
            </div>

            <div className="flex-1">
              <p className="text-sm font-bold leading-tight">Alex Learner</p>

              <p className="text-xs text-gray-500 font-medium">Free Plan</p>
            </div>

            <i className="fa-solid fa-gear text-gray-400"></i>
          </div>
        </div>
      </aside>

      {/* Main Content Wrapper */}

      <div className="flex-1 flex flex-col h-full relative overflow-hidden">
        {/* Top Header */}

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
            {titles[currentView]}
          </h2>

          <div className="flex items-center gap-4 ml-auto">
            <div className="flex items-center gap-2 bg-orange-100 px-3 py-1.5 rounded-full border border-orange-200">
              <i className="fa-solid fa-fire text-[#FFC107]"></i>

              <span className="font-bold text-orange-600 text-sm">12</span>
            </div>
          </div>
        </header>

        {/* Scrollable Views Area */}

        <main className="flex-1 overflow-y-auto pb-24 md:pb-0">
          {currentView === "home" && (
            <section className="p-6 max-w-5xl w-full mx-auto space-y-8 animate-[fadeIn_0.3s_ease-out]">
              <div className="bg-white rounded-3xl p-6 md:p-8 border-2 border-gray-200 shadow-sm flex flex-col md:flex-row items-center gap-8 relative overflow-hidden">
                <div className="flex-1 space-y-4 z-10 text-center md:text-left">
                  <h2 className="text-3xl md:text-4xl font-extrabold text-gray-900 tracking-tight">
                    Ready for your review?
                  </h2>

                  <p className="text-gray-500 font-medium text-lg">
                    You have{" "}
                    <span className="text-indigo-500 font-bold">24 cards</span>{" "}
                    due in your JLPT N5 deck. Keep your streak alive!
                  </p>
                </div>

                <button
                  onClick={() => navigate("study")}
                  className="active:translate-y-1 active:shadow-none transition-all w-full md:w-auto bg-indigo-500 text-white px-8 py-4 rounded-2xl font-bold text-lg shadow-[0_6px_0_0_#3F498A] hover:bg-indigo-600 z-10 flex items-center justify-center gap-3"
                >
                  Start Session <i className="fa-solid fa-play"></i>
                </button>
              </div>
            </section>
          )}

          {currentView === "decks" && (
            <section className="p-6 max-w-5xl w-full mx-auto space-y-8 animate-[fadeIn_0.3s_ease-out]">
              <div className="flex items-center gap-4">
                <div className="relative flex-1">
                  <i className="fa-solid fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>

                  <input
                    type="text"
                    placeholder="Search your decks..."
                    className="w-full pl-12 pr-4 py-3 bg-white border border-gray-200 rounded-xl focus:ring-2 focus:ring-indigo-500 outline-none"
                  />
                </div>

                <button
                  onClick={() => navigate("creator")}
                  className="active:translate-y-1 active:shadow-none transition-all bg-indigo-500 text-white px-6 py-3 rounded-xl font-bold shadow-[0_4px_0_0_#3F498A] hover:bg-indigo-600 flex items-center gap-2"
                >
                  <i className="fa-solid fa-plus"></i> Create Deck
                </button>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <div className="bg-white rounded-3xl p-6 border-2 border-gray-200 group hover:border-indigo-500 transition-colors cursor-pointer relative">
                  <span className="absolute top-4 right-4 bg-indigo-500 text-white text-xs font-bold px-3 py-1 rounded-full">
                    Premade
                  </span>

                  <span className="bg-gray-100 text-gray-600 text-xs font-bold px-2 py-1 rounded-md mb-4 inline-block">
                    🇯🇵 Japanese
                  </span>

                  <h4 className="font-extrabold text-xl group-hover:text-indigo-500 transition-colors tracking-tight">
                    JLPT N5 Core
                  </h4>

                  <p className="text-sm text-gray-500 mt-1 mb-6">
                    By BooMondai Official
                  </p>

                  <div className="flex justify-between items-center text-sm font-bold border-t border-gray-200 pt-4">
                    <span className="text-indigo-500">2,000 Cards</span>

                    <span className="text-green-600">95% Mastery</span>
                  </div>
                </div>
              </div>
            </section>
          )}
        </main>

        {/* Mobile Bottom Navigation */}

        <nav className="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 z-50 px-6 py-3 flex justify-between items-center pb-safe shadow-[0_-4px_20px_rgba(0,0,0,0.05)]">
          <MobileNavButton
            active={currentView === "home"}
            icon="fa-house"
            label="Home"
            onClick={() => switchView("home")}
          />

          <MobileNavButton
            active={currentView === "decks"}
            icon="fa-layer-group"
            label="Decks"
            onClick={() => switchView("decks")}
          />

          <button
            onClick={() => navigate("study")}
            className="active:translate-y-1 active:shadow-none transition-all w-14 h-14 rounded-full bg-indigo-500 text-white shadow-[0_4px_0_0_#3F498A] flex items-center justify-center text-2xl -mt-8 border-4 border-white"
          >
            <i className="fa-solid fa-play ml-1"></i>
          </button>

          <MobileNavButton
            active={currentView === "leaderboard"}
            icon="fa-trophy"
            label="Rank"
            onClick={() => switchView("leaderboard")}
          />

          <MobileNavButton
            active={currentView === "account"}
            icon="fa-user"
            label="Profile"
            onClick={() => switchView("account")}
          />
        </nav>
      </div>
    </div>
  );
}

// --- HELPER UI COMPONENTS ---

export function SidebarButton({
  active,

  icon,

  label,

  onClick,
}: {
  active: boolean;

  icon: string;

  label: string;

  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className={`w-full flex items-center gap-4 px-4 py-3 rounded-xl transition-colors ${active ? "bg-indigo-50 text-indigo-500 font-bold border-2 border-indigo-500/10" : "text-gray-500 font-semibold hover:bg-gray-100 border-2 border-transparent"}`}
    >
      <i className={`fa-solid ${icon} text-lg w-6`}></i> {label}
    </button>
  );
}

export function MobileNavButton({
  active,

  icon,

  label,

  onClick,
}: {
  active: boolean;

  icon: string;

  label: string;

  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className={`flex flex-col items-center gap-1 ${active ? "text-indigo-500" : "text-gray-400"}`}
    >
      <i className={`fa-solid ${icon} text-xl`}></i>

      <span className="text-[10px] font-bold">{label}</span>
    </button>
  );
}
