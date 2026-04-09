import { useNavigate } from "react-router-dom";

export default function Decks() {
  const navigate = useNavigate();

  return (
    <section className="p-6 max-w-5xl w-full mx-auto space-y-8 animate-[fadeIn_0.3s_ease-out]">
      {/* Top Action Bar */}
      <div className="flex items-center gap-4">
        <div className="relative flex-1">
          <i className="fa-solid fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>
          <input
            type="text"
            placeholder="Search your decks..."
            className="w-full pl-12 pr-4 py-3 bg-white border border-gray-200 rounded-xl focus:ring-2 focus:ring-indigo-500 outline-none transition-shadow"
          />
        </div>
        <button
          onClick={() => navigate("/creator")}
          className="active:translate-y-1 active:shadow-none transition-all bg-indigo-500 text-white px-6 py-3 rounded-xl font-bold shadow-[0_4px_0_0_#3F498A] hover:bg-indigo-600 flex items-center gap-2"
        >
          <i className="fa-solid fa-plus"></i> Create Deck
        </button>
      </div>

      {/* Deck Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {/* Deck Card 1 (Official/Premade) */}
        <div
          onClick={() => navigate("/study")}
          className="bg-white rounded-3xl p-6 border-2 border-gray-200 group hover:border-indigo-500 hover:shadow-md transition-all cursor-pointer relative flex flex-col min-h-[200px]"
        >
          <span className="absolute top-4 right-4 bg-indigo-500 text-white text-[10px] font-bold px-3 py-1 rounded-full uppercase tracking-wider">
            Premade
          </span>
          <span className="bg-gray-100 text-gray-600 text-xs font-bold px-2 py-1 rounded-md mb-4 inline-block w-max">
            🇯🇵 Japanese
          </span>
          <h4 className="font-extrabold text-xl group-hover:text-indigo-500 transition-colors tracking-tight line-clamp-2">
            JLPT N5 Core Vocabulary
          </h4>
          <p className="text-sm text-gray-500 mt-1 mb-6 flex-1">
            By BooMondai Official
          </p>

          <div className="flex justify-between items-end text-sm font-bold border-t border-gray-100 pt-4 mt-auto">
            <span className="text-indigo-500">2,000 Cards</span>
            <span className="text-green-600">
              <i className="fa-solid fa-check-circle mr-1"></i> 95% Mastery
            </span>
          </div>
        </div>

        {/* Deck Card 2 (User Created) */}
        <div
          onClick={() => navigate("/study")}
          className="bg-white rounded-3xl p-6 border-2 border-gray-200 group hover:border-indigo-500 hover:shadow-md transition-all cursor-pointer relative flex flex-col min-h-[200px]"
        >
          <span className="bg-gray-100 text-gray-600 text-xs font-bold px-2 py-1 rounded-md mb-4 inline-block w-max">
            🇪🇸 Spanish
          </span>
          <h4 className="font-extrabold text-xl group-hover:text-indigo-500 transition-colors tracking-tight line-clamp-2">
            Travel Survival Phrases
          </h4>
          <p className="text-sm text-gray-500 mt-1 mb-6 flex-1">By You</p>

          <div className="flex justify-between items-end text-sm font-bold border-t border-gray-100 pt-4 mt-auto">
            <span className="text-gray-500">120 Cards</span>
            <span className="text-orange-500">
              <i className="fa-solid fa-fire mr-1"></i> 24 Due
            </span>
          </div>
        </div>

        {/* Deck Card 3 (Empty/New Action) */}
        <div
          onClick={() => navigate("/creator")}
          className="bg-gray-50 rounded-3xl p-6 border-2 border-dashed border-gray-300 group hover:border-indigo-400 hover:bg-indigo-50 transition-all cursor-pointer relative flex flex-col min-h-[200px] items-center justify-center text-center"
        >
          <div className="w-12 h-12 rounded-full bg-white border-2 border-gray-200 flex items-center justify-center text-gray-400 group-hover:text-indigo-500 group-hover:border-indigo-300 mb-3 transition-colors shadow-sm">
            <i className="fa-solid fa-plus text-xl"></i>
          </div>
          <h4 className="font-extrabold text-lg text-gray-500 group-hover:text-indigo-600 transition-colors tracking-tight">
            Create New Deck
          </h4>
          <p className="text-sm text-gray-400 mt-1 font-medium">
            Start from scratch
          </p>
        </div>
      </div>
    </section>
  );
}
