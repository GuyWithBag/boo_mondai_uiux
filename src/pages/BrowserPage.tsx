import { useState, useRef, useEffect } from "react";

// --- Types ---
type SortCategory = "recency" | "alphabetical" | "usage";

interface FilterState {
  searchQuery: string;
  sortCategory: SortCategory;
  isAscending: boolean;
  selectedTags: string[];
}

interface DeckData {
  id: string;
  title: string;
  description: string;
  tags: string[];
  coverGradient: string;
  isSynced: boolean;
  usageCount: number;
  createdAt: number;
}

// --- Mock Data ---
const POPULAR_QUICK_TAGS = [
  {
    id: "tag-ja",
    label: "🇯🇵 日本語",
    colorClass:
      "bg-indigo-50 text-indigo-600 border-indigo-200 shadow-[#C7D2FE]",
  },
  {
    id: "tag-es",
    label: "🇪🇸 Español",
    colorClass:
      "bg-orange-50 text-orange-600 border-orange-200 shadow-[#FED7AA]",
  },
  {
    id: "tag-cloze",
    label: "🧩 Cloze",
    colorClass: "bg-teal-50 text-teal-600 border-teal-200 shadow-[#99F6E4]",
  },
  {
    id: "tag-leech",
    label: "🔥 Leeches",
    colorClass: "bg-rose-50 text-rose-600 border-rose-200 shadow-[#FECACA]",
  },
];

const TAG_GROUPS = [
  {
    id: "deck",
    title: "Deck Tags",
    tags: [
      "🇯🇵 日本語",
      "🇪🇸 Español",
      "Kanji",
      "Vocabulary",
      "Grammar",
      "Medical",
    ],
  },
  {
    id: "template",
    title: "Template Tags",
    tags: ["🧩 Cloze", "Standard", "Reversible", "Match Madness"],
  },
  {
    id: "review",
    title: "Review Card Tags",
    tags: ["🔥 Leeches", "Audio Included", "Visual Prompt", "Hard Mode"],
  },
];

const SORT_OPTIONS: { id: SortCategory; label: string }[] = [
  { id: "recency", label: "Date Created" },
  { id: "alphabetical", label: "A - Z Alphabet" },
  { id: "usage", label: "Frequency / Usage" },
];

const MOCK_PUBLIC_DECKS: DeckData[] = [
  {
    id: "d1",
    title: "JLPT N5 Core Vocabulary",
    description:
      "The absolute essentials for passing the N5. Includes native audio and stroke order diagrams.",
    tags: ["🇯🇵 日本語", "Kanji", "Audio Included"],
    coverGradient: "bg-gradient-to-br from-indigo-500 to-purple-600",
    isSynced: true,
    usageCount: 15420,
    createdAt: Date.now() - 1000000,
  },
  {
    id: "d2",
    title: "Español Conversational",
    description:
      "Rapid-fire phrases for travel and daily conversations in Madrid and Latin America.",
    tags: ["🇪🇸 Español", "Vocabulary", "🧩 Cloze"],
    coverGradient: "bg-gradient-to-br from-orange-400 to-rose-500",
    isSynced: true,
    usageCount: 8900,
    createdAt: Date.now() - 500000,
  },
  {
    id: "d3",
    title: "Python Machine Learning",
    description:
      "Pandas, NumPy, and PyTorch syntax memory drills for data science interviews.",
    tags: ["Vocabulary", "Hard Mode"],
    coverGradient: "bg-gradient-to-br from-emerald-400 to-teal-600",
    isSynced: true,
    usageCount: 4200,
    createdAt: Date.now() - 200000,
  },
  {
    id: "d4",
    title: "Advanced Medical Kanji",
    description:
      "High-level terminology used in Japanese clinical environments and medical literature.",
    tags: ["🇯🇵 日本語", "Kanji", "Medical"],
    coverGradient: "bg-gradient-to-br from-slate-700 to-gray-900",
    isSynced: true,
    usageCount: 1200,
    createdAt: Date.now() - 800000,
  },
];

// --- Custom Components ---

const QuickFilterTag = ({
  label,
  colorClass,
  selected,
  onClick,
}: {
  label: string;
  colorClass: string;
  selected: boolean;
  onClick: () => void;
}) => (
  <button
    onClick={onClick}
    className={`btn-tactile flex min-h-9 items-center justify-center gap-1.5 rounded-full border-2 px-4 text-xs font-black tracking-tight transition-all active:translate-y-1 active:shadow-none
    ${selected ? "translate-y-1 border-indigo-600 bg-indigo-600 text-white shadow-none" : `${colorClass} border-2 shadow-[0_4px_0_0_currentColor] hover:brightness-95`}`}
  >
    {label}
  </button>
);

const SortSelectorDropdown = ({
  category,
  isAscending,
  onSelectCategory,
  onToggleDirection,
}: {
  category: SortCategory;
  isAscending: boolean;
  onSelectCategory: (cat: SortCategory) => void;
  onToggleDirection: () => void;
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const handleOutsideClick = (e: MouseEvent) => {
      if (
        dropdownRef.current &&
        !dropdownRef.current.contains(e.target as Node)
      )
        setIsOpen(false);
    };
    document.addEventListener("mousedown", handleOutsideClick);
    return () => document.removeEventListener("mousedown", handleOutsideClick);
  }, []);

  const activeOption = SORT_OPTIONS.find((opt) => opt.id === category);

  return (
    <div
      ref={dropdownRef}
      className="relative flex items-center rounded-2xl border-2 border-gray-200 bg-white p-1 shadow-[0_4px_0_0_#E5E7EB]"
    >
      <button
        onClick={() => setIsOpen(!isOpen)}
        className="flex h-11 items-center px-4 text-left font-black text-gray-700 hover:bg-gray-50 transition-colors"
      >
        <div className="flex flex-col justify-center">
          <span className="text-[9px] uppercase tracking-widest text-gray-400 leading-none mb-0.5">
            Sort By
          </span>
          <span className="text-sm text-gray-800 leading-none">
            {activeOption?.label}
          </span>
        </div>
      </button>

      <div className="h-6 w-[2px] bg-gray-200 mx-1" />

      <button
        onClick={onToggleDirection}
        className="flex h-11 w-11 items-center justify-center rounded-xl bg-gray-50 text-indigo-500 hover:bg-indigo-50 transition-all border border-gray-100"
        title={isAscending ? "Ascending" : "Descending"}
      >
        <i
          className={`fa-solid ${isAscending ? "fa-arrow-up-long" : "fa-arrow-down-long"} text-base transition-transform duration-300`}
        />
      </button>

      {isOpen && (
        <div className="absolute left-0 top-16 z-30 w-52 overflow-hidden rounded-2xl border-2 border-gray-200 bg-white shadow-xl animate-[fadeIn_0.15s_ease-out]">
          <div className="p-1.5 space-y-0.5">
            {SORT_OPTIONS.map((option) => (
              <button
                key={option.id}
                onClick={() => {
                  onSelectCategory(option.id);
                  setIsOpen(false);
                }}
                className={`w-full text-left font-bold text-sm px-4 py-2.5 rounded-xl transition-colors flex items-center justify-between ${category === option.id ? "bg-indigo-50 text-indigo-600 font-black" : "text-gray-600 hover:bg-gray-50"}`}
              >
                {option.label}
                {category === option.id && (
                  <i className="fa-solid fa-check text-xs" />
                )}
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

/**
 * 3D Spreading Deck Card
 * Features an extruded tactile shadow showing bottom/right faces,
 * and a splitting animation (Top left, bottoms right) on hover.
 */
const Deck3DCard = ({ deck }: { deck: DeckData }) => {
  return (
    // hover:z-20 ensures spreading cards don't clip under adjacent grid items
    <div className="relative group w-full cursor-pointer h-80 hover:z-20 perspective-1000 pl-4 pt-2">
      {/* Layer 3: Bottom Card (Fans out furthest to the right) */}
      <div className="absolute inset-0 bg-white border-2 border-gray-200 rounded-2xl shadow-[4px_4px_0_0_#D1D5DB] transition-all duration-300 ease-out origin-bottom-left translate-x-2 translate-y-2 group-hover:translate-x-12 group-hover:translate-y-4 group-hover:rotate-6" />

      {/* Layer 2: Middle Card (Fans out slightly to the right) */}
      <div className="absolute inset-0 bg-white border-2 border-gray-200 rounded-2xl shadow-[4px_4px_0_0_#D1D5DB] transition-all duration-300 ease-out origin-bottom-left translate-x-1 translate-y-1 group-hover:translate-x-5 group-hover:translate-y-2 group-hover:rotate-3" />

      {/* Layer 1: Top Main Card
          - Strong gray-400 shadow (6px_6px) mimics a thick 3D physical object.
          - Moves up/left (-translate) and rotates left (-rotate) on hover.
      */}
      <div
        className={`absolute inset-0 border-2 border-gray-200 rounded-2xl shadow-[6px_6px_0_0_#9CA3AF] transition-all duration-300 ease-out origin-bottom-left group-hover:-translate-x-4 group-hover:-translate-y-2 group-hover:-rotate-3 z-10 overflow-hidden flex flex-col ${deck.coverGradient}`}
      >
        {/* Dark subtle overlay grid for texture */}
        <div className="absolute inset-0 opacity-10 bg-[radial-gradient(#ffffff_1px,transparent_1px)] [background-size:16px_16px]" />

        {/* Gradient vignette for perfect text contrast */}
        <div className="absolute inset-0 bg-gradient-to-t from-gray-900/95 via-gray-900/40 to-transparent" />

        {/* Content Container */}
        <div className="relative z-10 flex flex-col h-full p-5 text-white">
          {/* Top Row: Indicators */}
          <div className="flex justify-between items-start mb-auto">
            <div className="bg-white/20 backdrop-blur-md border border-white/20 px-2 py-1 text-[10px] font-black uppercase tracking-widest rounded-lg flex items-center gap-1.5 shadow-sm">
              <i className="fa-solid fa-users text-white/90" />{" "}
              {(deck.usageCount / 1000).toFixed(1)}k
            </div>
            <div className="flex gap-2">
              {deck.isSynced && (
                <div
                  className="bg-white/20 backdrop-blur-md border border-white/20 w-7 h-7 rounded-lg flex items-center justify-center shadow-sm"
                  title="Synced to Cloud"
                >
                  <i className="fa-solid fa-cloud text-xs text-white" />
                </div>
              )}
            </div>
          </div>

          {/* Bottom Row: Info & Tags */}
          <div className="mt-auto">
            <h4 className="text-2xl font-black leading-tight mb-2 drop-shadow-md">
              {deck.title}
            </h4>
            <p className="text-sm font-medium text-white/80 leading-relaxed line-clamp-2 mb-4 drop-shadow-sm">
              {deck.description}
            </p>

            {/* Glassmorphic Tags */}
            <div className="flex flex-wrap gap-2">
              {deck.tags.map((tag) => (
                <span
                  key={tag}
                  className="bg-white/20 backdrop-blur-md border border-white/20 text-white px-2.5 py-1 text-[10px] font-black uppercase tracking-wider rounded-lg shadow-sm"
                >
                  {tag}
                </span>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

// --- Main Page Component ---

export default function Browser() {
  const [isSheetOpen, setIsSheetOpen] = useState(false);
  const [filters, setFilters] = useState<FilterState>({
    searchQuery: "",
    sortCategory: "usage",
    isAscending: false,
    selectedTags: [],
  });

  const toggleTag = (tag: string) => {
    const selectedTags = filters.selectedTags.includes(tag)
      ? filters.selectedTags.filter((t) => t !== tag)
      : [...filters.selectedTags, tag];
    setFilters({ ...filters, selectedTags });
  };

  const handleReset = () => {
    setFilters({
      searchQuery: "",
      sortCategory: "usage",
      isAscending: false,
      selectedTags: [],
    });
  };

  const filteredDecks = MOCK_PUBLIC_DECKS.filter((deck) => {
    const matchesSearch =
      deck.title.toLowerCase().includes(filters.searchQuery.toLowerCase()) ||
      deck.description
        .toLowerCase()
        .includes(filters.searchQuery.toLowerCase());
    const matchesTags =
      filters.selectedTags.length === 0 ||
      filters.selectedTags.some((tag) => deck.tags.includes(tag));
    return matchesSearch && matchesTags;
  }).sort((a, b) => {
    let comparison = 0;
    if (filters.sortCategory === "recency")
      comparison = a.createdAt - b.createdAt;
    if (filters.sortCategory === "alphabetical")
      comparison = a.title.localeCompare(b.title);
    if (filters.sortCategory === "usage")
      comparison = a.usageCount - b.usageCount;
    return filters.isAscending ? comparison : -comparison;
  });

  return (
    <div className="min-h-screen bg-[#F8F9FA] p-6 sm:p-12 font-sans antialiased overflow-x-hidden">
      <div className="mx-auto max-w-5xl space-y-8">
        {/* Header */}
        <div>
          <h1 className="text-3xl font-black text-gray-900">Browser</h1>
          <p className="font-semibold text-gray-500">
            Explore public decks and master templates.
          </p>
        </div>

        {/* Row 1: Search, Sort, Filter */}
        <div className="flex w-full flex-col gap-4 sm:flex-row sm:items-center">
          <div className="relative flex-1">
            <i className="fa-solid fa-magnifying-glass absolute left-5 top-1/2 -translate-y-1/2 text-lg text-gray-400" />
            <input
              type="text"
              value={filters.searchQuery}
              onChange={(e) =>
                setFilters({ ...filters, searchQuery: e.target.value })
              }
              placeholder="Search master decks or keywords..."
              className="h-14 w-full rounded-2xl border-2 border-gray-200 bg-white pl-12 pr-12 text-base font-extrabold text-gray-900 outline-none placeholder:font-semibold placeholder:text-gray-400 focus:border-indigo-500 shadow-[0_4px_0_0_#E5E7EB]"
            />
          </div>

          <div className="flex items-center gap-3 self-end sm:self-auto">
            <SortSelectorDropdown
              category={filters.sortCategory}
              isAscending={filters.isAscending}
              onSelectCategory={(cat) =>
                setFilters({ ...filters, sortCategory: cat })
              }
              onToggleDirection={() =>
                setFilters({ ...filters, isAscending: !filters.isAscending })
              }
            />

            <button
              onClick={() => setIsSheetOpen(true)}
              className="relative flex h-14 w-14 items-center justify-center rounded-2xl border-2 border-gray-200 bg-white text-gray-500 shadow-[0_4px_0_0_#E5E7EB] hover:bg-gray-50 hover:text-gray-900 active:translate-y-1 active:shadow-none"
            >
              <i className="fa-solid fa-sliders text-xl" />
              {filters.selectedTags.length > 0 && (
                <span className="absolute -right-2 -top-2 flex h-6 w-6 items-center justify-center rounded-full border-2 border-white bg-indigo-500 text-[10px] font-black text-white shadow-sm">
                  {filters.selectedTags.length}
                </span>
              )}
            </button>
          </div>
        </div>

        {/* Row 2: Popular Dynamic Quick Tags */}
        <div className="flex flex-wrap items-center gap-3 px-1">
          <span className="text-[10px] font-black uppercase tracking-wider text-gray-400 mr-1">
            Frequent:
          </span>
          {POPULAR_QUICK_TAGS.map((tag) => (
            <QuickFilterTag
              key={tag.id}
              label={tag.label}
              colorClass={tag.colorClass}
              selected={filters.selectedTags.includes(tag.label)}
              onClick={() => toggleTag(tag.label)}
            />
          ))}
        </div>

        {/* Deck Grid OR Zero State */}
        {filteredDecks.length > 0 ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-x-8 gap-y-12 pt-4">
            {filteredDecks.map((deck) => (
              <Deck3DCard key={deck.id} deck={deck} />
            ))}
          </div>
        ) : (
          <div className="rounded-[40px] border-2 border-gray-200 bg-white p-12 text-center shadow-[0_4px_12px_rgba(229,231,235,0.55)] animate-[fadeIn_0.2s_ease-out] mt-8">
            <div className="relative mx-auto mb-6 flex h-28 w-28 items-center justify-center rounded-full bg-indigo-50">
              <div className="absolute -left-2 top-2 h-3 w-3 rounded-full bg-orange-400 animate-ping" />
              <div className="absolute -right-3 bottom-4 h-4 w-4 rounded-full bg-teal-400 opacity-60" />
              <span className="text-5xl transform -rotate-12 select-none">
                👻
              </span>
            </div>

            <h3 className="text-2xl font-black text-gray-900 mb-2 tracking-tight">
              No Decks Found!
            </h3>
            <p className="max-w-xs mx-auto text-sm font-semibold leading-relaxed text-gray-400 mb-8">
              We searched everywhere but couldn't find anything matching your
              exact criteria.
            </p>

            <button
              onClick={handleReset}
              className="btn-tactile mx-auto flex min-h-12 items-center justify-center gap-2 rounded-2xl bg-indigo-500 text-white px-8 py-3 text-sm font-extrabold shadow-[0_6px_0_0_#3F498A] hover:bg-indigo-600"
            >
              <i className="fa-solid fa-rotate" /> Reset Filters & Search
            </button>
          </div>
        )}
      </div>

      <DeepFilterDrawer
        isOpen={isSheetOpen}
        onClose={() => setIsSheetOpen(false)}
        selectedTags={filters.selectedTags}
        onTagToggle={toggleTag}
        onClearAll={() => setFilters({ ...filters, selectedTags: [] })}
      />
    </div>
  );
}

function DeepFilterDrawer({
  isOpen,
  onClose,
  selectedTags,
  onTagToggle,
  onClearAll,
}: {
  isOpen: boolean;
  onClose: () => void;
  selectedTags: string[];
  onTagToggle: (tag: string) => void;
  onClearAll: () => void;
}) {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex flex-col justify-end bg-gray-900/40 backdrop-blur-sm sm:items-center sm:justify-center">
      <div className="absolute inset-0" onClick={onClose} />
      <div className="relative flex max-h-[85vh] w-full flex-col rounded-t-[40px] border-t-2 border-gray-200 bg-white shadow-2xl sm:max-w-xl sm:rounded-[40px] sm:border-2 p-6 sm:p-8 overflow-hidden">
        <div className="flex items-center justify-between border-b-2 border-gray-100 pb-4 mb-6">
          <h2 className="text-xl font-black text-gray-900">
            Extended Tag Filters
          </h2>
          <div className="flex items-center gap-4">
            {selectedTags.length > 0 && (
              <button
                onClick={onClearAll}
                className="text-xs font-black text-indigo-500 uppercase tracking-wider hover:underline"
              >
                Clear Tags
              </button>
            )}
            <button
              onClick={onClose}
              className="flex h-8 w-8 items-center justify-center rounded-xl bg-gray-100 text-gray-500 hover:bg-gray-200"
            >
              <i className="fa-solid fa-xmark" />
            </button>
          </div>
        </div>

        <div className="flex-1 overflow-y-auto space-y-6 pr-1 no-scrollbar">
          {TAG_GROUPS.map((group) => (
            <div key={group.id} className="space-y-3">
              <h4 className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-400">
                {group.title}
              </h4>
              <div className="flex flex-wrap gap-2">
                {group.tags.map((tag) => {
                  const isSelected = selectedTags.includes(tag);
                  return (
                    <button
                      key={tag}
                      onClick={() => onTagToggle(tag)}
                      className={`flex min-h-9 items-center justify-center rounded-xl border-2 px-3 py-1 text-xs font-bold transition-all active:scale-95
                      ${isSelected ? "border-indigo-500 bg-indigo-50 text-indigo-500 font-extrabold shadow-none" : "border-gray-200 bg-white text-gray-500 shadow-[0_4px_0_0_#E5E7EB] hover:bg-gray-50"}`}
                    >
                      {tag}
                    </button>
                  );
                })}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
