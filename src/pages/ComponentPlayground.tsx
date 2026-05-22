import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

// --- Utility Components ---

const Section = ({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) => (
  <section className="mb-16">
    <h2 className="mb-6 border-b-2 border-gray-200 pb-2 text-[10px] font-black uppercase tracking-[0.2em] text-gray-400">
      {title}
    </h2>
    <div className="flex flex-wrap gap-8 items-end">{children}</div>
  </section>
);

const Surface = ({
  children,
  className = "",
}: {
  children: React.ReactNode;
  className?: string;
}) => (
  <div
    className={`rounded-[32px] border-2 border-gray-200 bg-white p-8 shadow-[0_4px_12px_rgba(229,231,235,0.55)] ${className}`}
  >
    {children}
  </div>
);

// --- 1. The Slider Knob (Switch) ---

const RidgeSwitch = ({ defaultOn = false }: { defaultOn?: boolean }) => {
  const [isOn, setIsOn] = useState(defaultOn);
  return (
    <button
      onClick={() => setIsOn(!isOn)}
      className={`relative flex h-10 w-20 items-center rounded-full p-1.5 transition-colors duration-300 shadow-inner border-2 ${
        isOn ? "bg-indigo-100 border-indigo-200" : "bg-gray-100 border-gray-200"
      }`}
    >
      {/* The Track Inset */}
      <div className="absolute inset-0 rounded-full shadow-[inset_0_2px_4px_rgba(0,0,0,0.05)] pointer-events-none" />

      {/* The Ridged Knob */}
      <div
        className={`relative flex h-7 w-7 items-center justify-center rounded-full bg-white shadow-[0_2px_4px_rgba(0,0,0,0.2)] border-2 transition-transform duration-300 z-10 ${
          isOn
            ? "translate-x-9 border-indigo-500"
            : "translate-x-0 border-gray-300"
        }`}
      >
        {/* Tactile Ridges */}
        <div className="flex gap-0.5">
          <div className="h-3 w-0.5 bg-gray-200 rounded-full" />
          <div className="h-3 w-0.5 bg-gray-200 rounded-full" />
        </div>
      </div>
    </button>
  );
};

// --- 2. The Stamp (Checkbox) ---

const StampCheckbox = ({
  defaultChecked = false,
}: {
  defaultChecked?: boolean;
}) => {
  const [isChecked, setIsChecked] = useState(defaultChecked);
  return (
    <button
      onClick={() => setIsChecked(!isChecked)}
      className={`flex h-10 w-10 items-center justify-center rounded-xl border-2 transition-all duration-150 ${
        isChecked
          ? "border-indigo-600 bg-indigo-50 text-indigo-600 shadow-[inset_0_4px_0_0_#C7D2FE] translate-y-1"
          : "border-gray-200 bg-white text-transparent shadow-[0_4px_0_0_#E5E7EB] hover:bg-gray-50 hover:-translate-y-0.5"
      }`}
    >
      <i
        className={`fa-solid fa-check text-xl transition-transform duration-200 font-black ${isChecked ? "scale-100" : "scale-50 opacity-0"}`}
      />
    </button>
  );
};

// --- 3. The Flipping Deck Loader ---

const FlippingDeckLoader = () => (
  <div className="flex flex-col items-center justify-center gap-4">
    <div className="relative w-16 h-12 perspective-1000">
      <div className="w-full h-full border-2 border-indigo-500 bg-indigo-50 rounded-lg shadow-sm animate-[cardFlip_1.2s_infinite_ease-in-out] flex items-center justify-center">
        <i className="fa-solid fa-layer-group text-indigo-500 text-xl" />
      </div>
    </div>
    <span className="text-[10px] font-black uppercase tracking-widest text-indigo-400 animate-pulse">
      Shuffling...
    </span>
  </div>
);

// --- 4. Sticker Tooltips ---

const StickerTooltip = ({
  text,
  children,
}: {
  text: string;
  children: React.ReactNode;
}) => {
  return (
    <div className="group relative inline-flex justify-center">
      {children}
      <div className="pointer-events-none absolute bottom-full mb-2 opacity-0 transition-all duration-200 group-hover:opacity-100 group-hover:-translate-y-1">
        {/* The Sticker Design */}
        <div className="relative rotate-3 rounded-lg border-4 border-white bg-[#FFD54F] px-4 py-2 text-xs font-black text-gray-900 shadow-[0_4px_8px_rgba(0,0,0,0.1)] whitespace-nowrap">
          {text}
          {/* Folded Corner Effect */}
          <div className="absolute -bottom-2 -right-2 h-4 w-4 bg-transparent shadow-[inset_2px_2px_0_0_#fff] rounded-tl-lg" />
        </div>
      </div>
    </div>
  );
};

// --- 5. Segmented Controller (Replaces Split Button) ---

const SegmentedController = () => {
  const [active, setActive] = useState<"front" | "back" | "both">("both");

  return (
    <div className="flex rounded-2xl bg-gray-100 p-1.5 shadow-inner border-2 border-gray-200">
      {(["front", "both", "back"] as const).map((tab) => (
        <button
          key={tab}
          onClick={() => setActive(tab)}
          className={`flex-1 rounded-xl px-6 py-2.5 text-sm font-extrabold transition-all duration-200 ${
            active === tab
              ? "bg-white text-indigo-600 shadow-[0_2px_4px_rgba(0,0,0,0.05)] border border-gray-200"
              : "text-gray-400 hover:text-gray-600"
          }`}
        >
          {tab.charAt(0).toUpperCase() + tab.slice(1)}
        </button>
      ))}
    </div>
  );
};

// --- Main Playground Interface ---

export default function ComponentPlaygroundDirector() {
  const navigate = useNavigate();

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isSnackbarOpen, setIsSnackbarOpen] = useState(false);

  useEffect(() => {
    if (isSnackbarOpen) {
      const timer = setTimeout(() => setIsSnackbarOpen(false), 3500);
      return () => clearTimeout(timer);
    }
  }, [isSnackbarOpen]);

  return (
    <div className="min-h-screen bg-[#F8F9FA] p-6 pb-32 sm:p-12 font-sans antialiased relative overflow-x-hidden">
      {/* Top Navigation */}
      <button
        onClick={() => navigate(-1)}
        className="btn-tactile fixed right-8 top-8 z-40 flex h-12 w-12 items-center justify-center rounded-2xl border-2 border-gray-200 bg-white text-gray-500 shadow-sm hover:bg-gray-50"
      >
        <i className="fa-solid fa-xmark text-xl" />
      </button>

      <main className="mx-auto max-w-5xl">
        <header className="mb-16">
          <div className="inline-flex h-8 items-center rounded-full bg-indigo-50 border border-indigo-200 px-3 mb-4">
            <span className="text-[10px] font-black uppercase text-indigo-500 tracking-widest">
              <i className="fa-solid fa-clapperboard mr-1" /> Director's Cut
            </span>
          </div>
          <h1 className="text-4xl font-black text-gray-900 mb-2">
            Mechanical UI Lab
          </h1>
          <p className="text-lg font-semibold text-gray-500">
            Pushing tactile feedback to the absolute limit.
          </p>
        </header>

        <Surface>
          <Section title="Hardware Inputs">
            <div className="flex flex-col gap-3">
              <span className="text-[10px] font-bold text-gray-400 uppercase">
                Ridge Sliders
              </span>
              <div className="flex gap-6">
                <RidgeSwitch defaultOn={true} />
                <RidgeSwitch defaultOn={false} />
              </div>
            </div>
            <div className="flex flex-col gap-3 ml-8">
              <span className="text-[10px] font-bold text-gray-400 uppercase">
                Stamp Checkboxes
              </span>
              <div className="flex gap-6">
                <StampCheckbox defaultChecked={true} />
                <StampCheckbox defaultChecked={false} />
              </div>
            </div>
          </Section>

          <Section title="Motion & Guidance">
            <FlippingDeckLoader />
            <div className="ml-16 flex flex-col gap-4">
              <StickerTooltip text="Hey! Don't forget to review!">
                <button className="font-extrabold text-indigo-500 border-b-2 border-indigo-200 border-dashed pb-0.5 mt-4">
                  Hover for Sticker Tooltip
                </button>
              </StickerTooltip>
            </div>
          </Section>

          <Section title="Grouped Actions">
            <div className="flex flex-col gap-4 w-full max-w-sm">
              <span className="text-[10px] font-bold text-gray-400 uppercase">
                Segmented Controller
              </span>
              <SegmentedController />
            </div>
          </Section>

          <Section title="Overlays & Interruptions">
            <div className="flex gap-4">
              <button
                onClick={() => setIsModalOpen(true)}
                className="btn-tactile rounded-2xl bg-indigo-50 border-2 border-indigo-200 text-indigo-600 font-extrabold px-6 py-3 shadow-[0_4px_0_0_#C7D2FE] active:translate-y-1 active:shadow-none"
              >
                Drop Heavy Modal
              </button>
              <button
                onClick={() => setIsSnackbarOpen(true)}
                className="btn-tactile rounded-2xl bg-orange-50 border-2 border-orange-200 text-orange-600 font-extrabold px-6 py-3 shadow-[0_4px_0_0_#FED7AA] active:translate-y-1 active:shadow-none"
              >
                Pop Arcade Snackbar
              </button>
            </div>
          </Section>
        </Surface>
      </main>

      {/* --- Fixed Global Components --- */}

      {/* The Mechanical Key FAB (Extremely Thick) */}
      <button className="fixed bottom-8 right-8 z-40 flex h-16 w-16 items-center justify-center rounded-2xl bg-indigo-500 text-white border-2 border-indigo-700 shadow-[0_8px_0_0_#3F498A] transition-all hover:bg-indigo-400 active:translate-y-2 active:shadow-none">
        <i className="fa-solid fa-plus text-2xl" />
      </button>

      {/* Extended Mechanical FAB */}
      <button className="fixed bottom-8 left-8 z-40 flex h-16 items-center justify-center gap-3 rounded-2xl bg-white border-2 border-gray-300 px-6 text-gray-800 shadow-[0_8px_0_0_#D1D5DB] transition-all hover:bg-gray-50 active:translate-y-2 active:shadow-[0_0px_0_0_#D1D5DB] active:border-gray-400">
        <div className="flex h-8 w-8 items-center justify-center rounded-xl bg-gray-100 text-gray-600 border border-gray-200">
          <i className="fa-solid fa-layer-group text-sm" />
        </div>
        <span className="font-extrabold text-sm">Study Queue</span>
      </button>

      {/* --- Overlays --- */}

      {/* The Heavy Slab Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/40 backdrop-blur-sm p-4 perspective-1000">
          {/* Notice the border-b-8 for massive physical weight */}
          <div className="relative w-full max-w-sm rounded-[32px] bg-white border-2 border-b-[12px] border-gray-200 p-8 text-center shadow-2xl animate-[dropIn_0.3s_cubic-bezier(0.175,0.885,0.32,1.275)]">
            <div className="mx-auto flex h-16 w-16 items-center justify-center rounded-[20px] bg-red-100 border-2 border-red-200 text-red-500 mb-6 shadow-inner">
              <i className="fa-solid fa-bomb text-3xl" />
            </div>
            <h3 className="text-2xl font-black text-gray-900 mb-2">
              Nuke this Deck?
            </h3>
            <p className="text-sm font-semibold text-gray-500 mb-8 leading-relaxed">
              This action is permanent. All flashcards, reviews, and progress
              will be turned to dust.
            </p>
            <div className="flex gap-3">
              <button
                onClick={() => setIsModalOpen(false)}
                className="flex-1 rounded-2xl border-2 border-gray-200 bg-white py-3 font-extrabold text-gray-600 shadow-[0_4px_0_0_#E5E7EB] active:translate-y-1 active:shadow-none"
              >
                Nevermind
              </button>
              <button
                onClick={() => setIsModalOpen(false)}
                className="flex-1 rounded-2xl border-2 border-red-500 bg-red-500 py-3 font-extrabold text-white shadow-[0_4px_0_0_#B91C1C] active:translate-y-1 active:shadow-none"
              >
                Nuke It
              </button>
            </div>
          </div>
        </div>
      )}

      {/* The Arcade Ticket Snackbar */}
      {isSnackbarOpen && (
        <div className="fixed top-8 right-8 z-50 w-80 overflow-hidden rounded-2xl border-4 border-gray-900 bg-[#FFD54F] shadow-[6px_6px_0_0_#111827] animate-[slideInRight_0.3s_ease-out]">
          {/* Neon Fuse Bar at the TOP */}
          <div className="h-2 w-full bg-orange-400">
            <div
              className="h-full bg-white opacity-50 rounded-r-full"
              style={{ animation: "shrink 3.5s linear forwards" }}
            />
          </div>
          <div className="flex items-start gap-4 p-5">
            <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-white border-2 border-gray-900">
              <i className="fa-solid fa-star text-orange-500 text-lg" />
            </div>
            <div>
              <h4 className="font-black text-gray-900 text-sm uppercase tracking-wide">
                Streak Saved!
              </h4>
              <p className="text-xs font-bold text-gray-800 mt-0.5">
                You reviewed 24 cards today.
              </p>
            </div>
          </div>
        </div>
      )}

      {/* Custom CSS Keyframes for the mechanical physics */}
      <style>{`
        @keyframes shrink {
          from { width: 100%; }
          to { width: 0%; }
        }
        @keyframes cardFlip {
          0% { transform: rotateY(0deg); }
          50% { transform: rotateY(180deg); background-color: #E0E7FF; }
          100% { transform: rotateY(360deg); }
        }
        @keyframes dropIn {
          0% { opacity: 0; transform: translateY(-40px) rotateX(10deg); }
          100% { opacity: 1; transform: translateY(0) rotateX(0deg); }
        }
        @keyframes slideInRight {
          0% { opacity: 0; transform: translateX(50px); }
          100% { opacity: 1; transform: translateX(0); }
        }
      `}</style>
    </div>
  );
}
