import { useNavigate } from "react-router-dom";
import { useSettings } from "../contexts/SettingsContext";

export default function Home() {
  const navigate = useNavigate();
  const { showNotchMargin } = useSettings();

  // Mock data for the activity graph
  const weeklyActivity = [
    { day: "Mon", xp: 120, height: "40%" },
    { day: "Tue", xp: 240, height: "80%" },
    { day: "Wed", xp: 150, height: "50%" },
    { day: "Thu", xp: 300, height: "100%", isToday: true },
    { day: "Fri", xp: 0, height: "5%" },
    { day: "Sat", xp: 0, height: "5%" },
    { day: "Sun", xp: 0, height: "5%" },
  ];

  return (
    <section className={`p-6 max-w-5xl w-full mx-auto space-y-6 animate-[fadeIn_0.3s_ease-out] ${showNotchMargin ? 'pt-10' : 'pt-0'}`}>
      {/* HERO CTA */}
      <div className="bg-white rounded-3xl p-6 md:p-8 border-2 border-gray-200 shadow-sm flex flex-col md:flex-row items-center gap-8 relative overflow-hidden">
        <div className="flex-1 space-y-4 z-10 text-center md:text-left">
          <h2 className="text-3xl md:text-4xl font-extrabold text-gray-900 tracking-tight">
            Ready for your review?
          </h2>
          <p className="text-gray-500 font-medium text-lg">
            You have <span className="text-indigo-500 font-bold">24 cards</span>{" "}
            due in your JLPT N5 deck. Keep your streak alive!
          </p>
        </div>
        <button
          onClick={() => navigate("/study")}
          className="active:translate-y-1 active:shadow-none transition-all w-full md:w-auto bg-indigo-500 text-white px-8 py-4 rounded-2xl font-bold text-lg shadow-[0_6px_0_0_#3F498A] hover:bg-indigo-600 z-10 flex items-center justify-center gap-3"
        >
          Start Session <i className="fa-solid fa-play"></i>
        </button>
      </div>

      {/* DASHBOARD GRID: Graph & Leaderboard */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Panel 1: Activity Graph */}
        <div className="bg-white rounded-3xl p-6 border-2 border-gray-200 shadow-sm flex flex-col">
          <div className="flex justify-between items-end mb-6">
            <div>
              <h3 className="font-extrabold text-gray-900 text-xl">Activity</h3>
              <p className="text-sm text-gray-500 font-medium mt-1">
                This week's XP
              </p>
            </div>
            <div className="text-2xl font-extrabold text-indigo-500">
              810 <span className="text-sm text-gray-400 font-bold">XP</span>
            </div>
          </div>

          {/* Custom CSS Bar Chart */}
          <div className="flex-1 flex items-end justify-between gap-2 h-40 mt-auto border-b-2 border-gray-100 pb-2">
            {weeklyActivity.map((day, idx) => (
              <div
                key={idx}
                className="w-full flex flex-col items-center group relative h-full justify-end"
              >
                {/* Tooltip on hover */}
                <div className="opacity-0 group-hover:opacity-100 absolute -top-8 bg-gray-900 text-white text-xs font-bold py-1 px-2 rounded transition-opacity whitespace-nowrap z-10">
                  {day.xp} XP
                </div>
                {/* The Bar */}
                <div
                  className={`w-full rounded-t-md transition-all duration-500 ${
                    day.isToday
                      ? "bg-indigo-500"
                      : day.xp > 0
                        ? "bg-indigo-200 group-hover:bg-indigo-300"
                        : "bg-gray-100"
                  }`}
                  style={{ height: day.height }}
                ></div>
              </div>
            ))}
          </div>

          <div className="flex justify-between mt-3 px-1">
            {weeklyActivity.map((day, idx) => (
              <span
                key={idx}
                className={`text-xs font-bold w-full text-center ${day.isToday ? "text-indigo-500" : "text-gray-400"}`}
              >
                {day.day}
              </span>
            ))}
          </div>
        </div>

        {/* Panel 2: Mini Leaderboard */}
        <div className="bg-white rounded-3xl p-6 border-2 border-gray-200 shadow-sm flex flex-col">
          <div className="flex justify-between items-center mb-6">
            <div>
              <h3 className="font-extrabold text-gray-900 text-xl">
                Sapphire League
              </h3>
              <p className="text-sm text-gray-500 font-medium mt-1">
                Top 10 advance to Ruby
              </p>
            </div>
            <button
              onClick={() => navigate("/leaderboard")}
              className="text-indigo-500 font-bold text-sm hover:underline"
            >
              View All
            </button>
          </div>

          <div className="space-y-3">
            {/* Rank 1 */}
            <div className="flex items-center gap-3 p-3 rounded-2xl bg-[#FFC107]/10 border border-[#FFC107]/30">
              <div className="w-6 text-center font-extrabold text-[#FFC107]">
                1
              </div>
              <div className="w-10 h-10 rounded-full bg-white border-2 border-[#FFC107] flex items-center justify-center font-bold text-gray-600 shadow-sm">
                Y
              </div>
              <div className="flex-1">
                <p className="font-bold text-gray-900 text-sm">Yoda_Master</p>
              </div>
              <div className="text-right">
                <p className="font-extrabold text-[#FFC107] text-sm">1850 XP</p>
              </div>
            </div>

            {/* Rank 2 */}
            <div className="flex items-center gap-3 p-3 rounded-2xl bg-gray-50 border border-gray-100">
              <div className="w-6 text-center font-extrabold text-gray-400">
                2
              </div>
              <div className="w-10 h-10 rounded-full bg-indigo-100 flex items-center justify-center font-bold text-indigo-500">
                S
              </div>
              <div className="flex-1">
                <p className="font-bold text-gray-900 text-sm">Sarah_J</p>
              </div>
              <div className="text-right">
                <p className="font-extrabold text-gray-600 text-sm">1620 XP</p>
              </div>
            </div>

            <div className="flex justify-center py-1">
              <i className="fa-solid fa-ellipsis-vertical text-gray-300"></i>
            </div>

            {/* Current User */}
            <div className="flex items-center gap-3 p-3 rounded-2xl bg-indigo-50 border-2 border-indigo-500 shadow-sm relative">
              <div className="absolute -left-2 w-1 h-8 bg-indigo-500 rounded-r-md"></div>
              <div className="w-6 text-center font-extrabold text-indigo-500">
                4
              </div>
              <div className="w-10 h-10 rounded-full bg-indigo-500 flex items-center justify-center font-bold text-white shadow-sm">
                AL
              </div>
              <div className="flex-1">
                <p className="font-bold text-indigo-700 text-sm">You</p>
              </div>
              <div className="text-right">
                <p className="font-extrabold text-indigo-500 text-sm">
                  1420 XP
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
