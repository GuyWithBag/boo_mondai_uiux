import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useSettings } from "../contexts/SettingsContext";

// --- Types ---
type QuestionFormat = "normal" | "mcq" | "blanks" | "match";

interface BaseCard {
  id: string;
  type: QuestionFormat;
}

interface Flashcard extends BaseCard {
  type: "normal";
  front: string;
  back: string;
}

interface MCQCard extends BaseCard {
  type: "mcq";
  prompt: string;
  options: string[];
  correctOption: string;
}

interface BlanksCard extends BaseCard {
  type: "blanks";
  prefix: string;
  blankAnswer: string;
  suffix: string;
}

interface MatchCard extends BaseCard {
  type: "match";
  pairs: { term: string; match: string }[];
}

type QuizCard = Flashcard | MCQCard | BlanksCard | MatchCard;

// --- MOCK DATA QUEUE ---
const mockQueue: QuizCard[] = [
  { id: "1", type: "normal", front: "勉強", back: "benkyou (study)" },
  {
    id: "2",
    type: "mcq",
    prompt: "Which particle indicates the topic of a sentence?",
    options: ["を (o)", "は (wa)", "が (ga)", "で (de)"],
    correctOption: "は (wa)",
  },
  {
    id: "3",
    type: "blanks",
    prefix: "私は毎日",
    blankAnswer: "図書館",
    suffix: "で勉強します。",
  },
  {
    id: "4",
    type: "match",
    pairs: [
      { term: "犬", match: "Dog" },
      { term: "猫", match: "Cat" },
      { term: "鳥", match: "Bird" },
    ],
  },
];

export default function StudySession() {
  const navigate = useNavigate();
  const { showNotchMargin } = useSettings();

  const [currentIndex, setCurrentIndex] = useState(0);
  const [isRevealed, setIsRevealed] = useState(false);

  const [selectedOption, setSelectedOption] = useState<string | null>(null);
  const [blankInput, setBlankInput] = useState("");

  const [selectedMatchA, setSelectedMatchA] = useState<string | null>(null);
  const [matchedPairs, setMatchedPairs] = useState<string[]>([]);

  const currentCard = mockQueue[currentIndex];
  const progress = (currentIndex / mockQueue.length) * 100;

  useEffect(() => {
    setIsRevealed(false);
    setSelectedOption(null);
    setBlankInput("");
    setSelectedMatchA(null);
    setMatchedPairs([]);
  }, [currentIndex]);

  const handleRate = (rating: string) => {
    console.log(`Card ${currentCard.id} rated: ${rating}`);
    if (currentIndex < mockQueue.length - 1) {
      setCurrentIndex(currentIndex + 1);
    } else {
      alert("Session Complete! You're all caught up.");
      navigate("/");
    }
  };

  const handleCheckAnswer = () => {
    setIsRevealed(true);
  };

  // --- RENDERERS FOR DIFFERENT CARD TYPES ---

  const renderFlashcard = (card: Flashcard) => (
    <div
      className="w-full max-w-[340px] md:max-w-[460px] mx-auto aspect-[3/4] md:aspect-[4/5] cursor-pointer"
      style={{ perspective: "1000px" }}
      onClick={() => setIsRevealed(true)}
    >
      <div
        className="relative w-full h-full transition-transform duration-500 shadow-md rounded-[32px]"
        style={{
          transformStyle: "preserve-3d",
          transform: isRevealed ? "rotateY(180deg)" : "rotateY(0deg)",
        }}
      >
        <div
          className="absolute inset-0 bg-white border-2 border-gray-200 rounded-[32px] flex flex-col items-center justify-center p-8 md:p-12 text-center"
          style={{ backfaceVisibility: "hidden" }}
        >
          <h2 className="text-5xl md:text-7xl font-extrabold text-gray-900 tracking-tight leading-tight">
            {card.front}
          </h2>
          <p className="text-gray-400 font-medium mt-auto absolute bottom-8 md:bottom-10 animate-pulse text-sm md:text-base">
            <i className="fa-solid fa-hand-pointer mr-2"></i> Tap to reveal
          </p>
        </div>
        <div
          className="absolute inset-0 bg-white border-2 border-indigo-500 rounded-[32px] flex flex-col items-center justify-center p-8 md:p-12 text-center shadow-[0_8px_30px_rgba(99,102,241,0.15)]"
          style={{ backfaceVisibility: "hidden", transform: "rotateY(180deg)" }}
        >
          <h2 className="text-3xl md:text-5xl font-extrabold text-gray-900 mb-6 leading-tight">
            {card.front}
          </h2>
          <div className="w-12 md:w-16 h-1 bg-gray-200 rounded-full mb-8"></div>
          <h3 className="text-2xl md:text-4xl font-bold text-indigo-500">
            {card.back}
          </h3>
        </div>
      </div>
    </div>
  );

  const renderMCQ = (card: MCQCard) => (
    <div className="w-full max-w-[340px] md:max-w-[480px] mx-auto min-h-[460px] md:min-h-[540px] bg-white border-2 border-gray-200 rounded-[32px] p-6 md:p-10 shadow-md flex flex-col justify-between animate-[fadeIn_0.3s_ease-out]">
      <div className="flex flex-col items-center pt-4">
        <h2 className="text-sm font-extrabold text-gray-400 uppercase tracking-widest mb-6 md:mb-8">
          Select Answer
        </h2>
        <h3 className="text-xl md:text-2xl font-extrabold text-gray-900 mb-8 text-center leading-snug">
          {card.prompt}
        </h3>
      </div>

      <div className="space-y-3 md:space-y-4 w-full pb-2">
        {card.options.map((option) => {
          const isSelected = selectedOption === option;
          const isCorrect = option === card.correctOption;

          let btnClass =
            "border-gray-200 hover:border-indigo-500 hover:bg-indigo-50 text-gray-700 bg-white";

          if (isRevealed) {
            if (isCorrect)
              btnClass =
                "border-green-500 bg-green-50 text-green-700 shadow-[0_4px_0_0_#4CAF50]";
            else if (isSelected && !isCorrect)
              btnClass = "border-red-500 bg-red-50 text-red-700 opacity-50";
            else btnClass = "border-gray-200 bg-white opacity-50";
          } else if (isSelected) {
            btnClass =
              "border-indigo-500 bg-indigo-50 text-indigo-700 shadow-[0_4px_0_0_#5C6BC0]";
          }

          return (
            <button
              key={option}
              disabled={isRevealed}
              onClick={() => setSelectedOption(option)}
              className={`w-full p-4 md:p-5 rounded-2xl border-2 font-bold text-base md:text-lg text-left transition-all ${btnClass}`}
            >
              {option}
            </button>
          );
        })}
      </div>
    </div>
  );

  const renderBlanks = (card: BlanksCard) => {
    const isCorrect =
      blankInput.trim().toLowerCase() === card.blankAnswer.toLowerCase();
    const inputClass = isRevealed
      ? isCorrect
        ? "bg-green-50 text-green-700 border-green-500"
        : "bg-red-50 text-red-700 border-red-500 line-through"
      : "bg-gray-50 border-gray-300 focus:border-indigo-500 focus:bg-white text-indigo-500";

    return (
      <div className="w-full max-w-[340px] md:max-w-[480px] mx-auto min-h-[460px] md:min-h-[540px] bg-white border-2 border-gray-200 rounded-[32px] p-6 md:p-10 shadow-md flex flex-col items-center justify-center text-center animate-[fadeIn_0.3s_ease-out]">
        <h2 className="text-sm font-extrabold text-gray-400 uppercase tracking-widest mb-10 md:mb-12">
          Fill in the blank
        </h2>

        <div className="text-2xl md:text-3xl font-extrabold text-gray-900 leading-loose flex flex-wrap items-center justify-center gap-2 md:gap-3">
          <span>{card.prefix}</span>
          <div className="relative inline-block w-full my-2 md:my-4">
            <input
              type="text"
              disabled={isRevealed}
              value={blankInput}
              onChange={(e) => setBlankInput(e.target.value)}
              className={`w-[80%] md:w-[70%] text-center font-bold px-4 py-2 md:py-3 rounded-xl border-b-4 outline-none transition-colors ${inputClass}`}
            />
            {isRevealed && !isCorrect && (
              <span className="absolute -bottom-8 md:-bottom-10 left-1/2 -translate-x-1/2 text-sm md:text-base font-bold text-green-500 bg-green-50 border border-green-200 px-3 py-1 rounded-lg shadow-sm whitespace-nowrap">
                {card.blankAnswer}
              </span>
            )}
          </div>
          <span>{card.suffix}</span>
        </div>
      </div>
    );
  };

  const renderMatch = (card: MatchCard) => {
    const terms = card.pairs.map((p) => p.term);
    const matches = card.pairs.map((p) => p.match);

    const handleMatchClick = (item: string, isTerm: boolean) => {
      if (isRevealed) return;
      if (!selectedMatchA) {
        setSelectedMatchA(item);
      } else {
        const isPair = card.pairs.some(
          (p) =>
            (p.term === selectedMatchA && p.match === item) ||
            (p.match === selectedMatchA && p.term === item),
        );

        if (isPair) {
          const newMatched = [...matchedPairs, selectedMatchA, item];
          setMatchedPairs(newMatched);
          if (newMatched.length === card.pairs.length * 2) {
            setIsRevealed(true);
          }
        }
        setSelectedMatchA(null);
      }
    };

    return (
      <div className="w-full max-w-[340px] md:max-w-[480px] mx-auto min-h-[460px] md:min-h-[540px] bg-white border-2 border-gray-200 rounded-[32px] p-6 md:p-10 shadow-md flex flex-col justify-center animate-[fadeIn_0.3s_ease-out]">
        <h2 className="text-sm font-extrabold text-gray-400 uppercase tracking-widest mb-8 md:mb-12 text-center">
          Match the pairs
        </h2>

        <div className="grid grid-cols-2 gap-3 md:gap-5 w-full">
          <div className="space-y-3 md:space-y-5">
            {terms.map((term) => (
              <button
                key={term}
                disabled={matchedPairs.includes(term) || isRevealed}
                onClick={() => handleMatchClick(term, true)}
                className={`w-full py-4 md:py-6 px-2 md:px-4 rounded-xl md:rounded-2xl border-2 font-bold text-sm md:text-base text-center transition-all ${
                  matchedPairs.includes(term)
                    ? "opacity-0"
                    : selectedMatchA === term
                      ? "border-indigo-500 bg-indigo-50 text-indigo-500 shadow-[0_4px_0_0_#5C6BC0]"
                      : "border-gray-200 hover:border-gray-300 bg-gray-50 hover:bg-white text-gray-700"
                }`}
              >
                {term}
              </button>
            ))}
          </div>
          <div className="space-y-3 md:space-y-5">
            {matches.map((match) => (
              <button
                key={match}
                disabled={matchedPairs.includes(match) || isRevealed}
                onClick={() => handleMatchClick(match, false)}
                className={`w-full py-4 md:py-6 px-2 md:px-4 rounded-xl md:rounded-2xl border-2 font-bold text-sm md:text-base text-center transition-all ${
                  matchedPairs.includes(match)
                    ? "opacity-0"
                    : selectedMatchA === match
                      ? "border-indigo-500 bg-indigo-50 text-indigo-500 shadow-[0_4px_0_0_#5C6BC0]"
                      : "border-gray-200 hover:border-gray-300 bg-gray-50 hover:bg-white text-gray-700"
                }`}
              >
                {match}
              </button>
            ))}
          </div>
        </div>
      </div>
    );
  };

  return (
    <div 
      className={`absolute inset-0 z-50 bg-[#F8F9FA] flex flex-col w-full h-full overflow-hidden transition-all duration-300 ${showNotchMargin ? 'pt-10' : 'pt-0'}`}
    >
      {/* Top Progress Bar */}
      <div className="px-6 py-4 flex items-center gap-4 border-b border-gray-200/50 shrink-0">
        <button
          onClick={() => navigate(-1)}
          className="text-gray-400 hover:text-gray-700 transition-colors"
        >
          <i className="fa-solid fa-xmark text-2xl"></i>
        </button>
        <div className="flex-1 h-3 md:h-4 bg-gray-200 rounded-full overflow-hidden">
          <div
            className="h-full bg-indigo-500 rounded-full transition-all duration-500 relative"
            style={{ width: `${progress}%` }}
          >
            <div className="absolute top-0.5 left-2 right-2 h-0.5 md:h-1 md:top-1 bg-white/30 rounded-full"></div>
          </div>
        </div>
        <div className="text-xs md:text-sm font-bold text-gray-400 uppercase tracking-widest">
          {currentIndex + 1} / {mockQueue.length}
        </div>
      </div>

      {/* Main Content Area */}
      <div className="flex-1 flex flex-col items-center justify-center px-4 overflow-y-auto pb-36 pt-8 md:pt-12">
        {currentCard.type === "normal" &&
          renderFlashcard(currentCard as Flashcard)}
        {currentCard.type === "mcq" && renderMCQ(currentCard as MCQCard)}
        {currentCard.type === "blanks" &&
          renderBlanks(currentCard as BlanksCard)}
        {currentCard.type === "match" && renderMatch(currentCard as MatchCard)}
      </div>

      {/* Bottom Action Area (Sticky) */}
      <div className="absolute bottom-0 left-0 right-0 p-6 md:p-8 bg-white border-t border-gray-200 rounded-t-3xl md:rounded-t-[40px] shadow-[0_-10px_40px_rgba(0,0,0,0.05)] shrink-0">
        {!isRevealed &&
          currentCard.type !== "normal" &&
          currentCard.type !== "match" && (
            <div className="w-full max-w-[340px] md:max-w-[480px] mx-auto">
              <button
                onClick={handleCheckAnswer}
                disabled={
                  (currentCard.type === "mcq" && !selectedOption) ||
                  (currentCard.type === "blanks" && !blankInput)
                }
                className="w-full block active:translate-y-1 active:shadow-none disabled:opacity-50 disabled:active:translate-y-0 disabled:cursor-not-allowed bg-indigo-500 text-white px-8 py-4 md:py-5 rounded-2xl md:rounded-[20px] font-bold text-lg md:text-xl shadow-[0_6px_0_0_#3F498A] hover:bg-indigo-600 transition-all"
              >
                Check Answer
              </button>
            </div>
          )}

        {isRevealed && (
          <div className="animate-[fadeIn_0.3s_ease-out]">
            <h4 className="text-center text-xs md:text-sm font-bold text-gray-400 mb-4 md:mb-6 uppercase tracking-widest">
              How well did you know this?
            </h4>
            <div className="grid grid-cols-4 gap-2 md:gap-4 w-full max-w-[340px] md:max-w-[480px] mx-auto">
              <RatingButton
                color="red"
                label="Again"
                time="1m"
                shadow="#ffcdd2"
                onClick={() => handleRate("again")}
              />
              <RatingButton
                color="orange"
                label="Hard"
                time="6m"
                shadow="#ffe0b2"
                onClick={() => handleRate("hard")}
              />
              <RatingButton
                color="green"
                label="Good"
                time="10m"
                shadow="#c8e6c9"
                onClick={() => handleRate("good")}
              />
              <RatingButton
                color="blue"
                label="Easy"
                time="4d"
                shadow="#bbdefb"
                onClick={() => handleRate("easy")}
              />
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

// --- HELPER COMPONENT ---
function RatingButton({
  color,
  label,
  time,
  shadow,
  onClick,
}: {
  color: string;
  label: string;
  time: string;
  shadow: string;
  onClick: () => void;
}) {
  const bgClasses: Record<string, string> = {
    red: "bg-red-50 text-[#F44336] border-red-200 hover:bg-red-100",
    orange: "bg-orange-50 text-[#FF9800] border-orange-200 hover:bg-orange-100",
    green: "bg-green-50 text-[#4CAF50] border-green-200 hover:bg-green-100",
    blue: "bg-blue-50 text-[#2196F3] border-blue-200 hover:bg-blue-100",
  };

  return (
    <button
      onClick={onClick}
      className={`active:translate-y-1 active:shadow-none transition-all border-2 rounded-[20px] md:rounded-3xl py-3 md:py-4 px-1 flex flex-col items-center justify-center cursor-pointer ${bgClasses[color]}`}
      style={{ boxShadow: `0 4px 0 0 ${shadow}` }}
    >
      <span className="font-extrabold text-xs md:text-sm uppercase tracking-tight">
        {label}
      </span>
      <span className="text-[10px] md:text-xs font-bold opacity-70 mt-1">
        {time}
      </span>
    </button>
  );
}
