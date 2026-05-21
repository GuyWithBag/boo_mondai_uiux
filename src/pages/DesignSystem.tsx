import React from "react";
import { useNavigate } from "react-router-dom";
import { useSettings } from "../contexts/useSettings";

type Tone =
  | "filled"
  | "ghost"
  | "text"
  | "dashed"
  | "streak"
  | "success"
  | "error"
  | "again"
  | "hard"
  | "good"
  | "easy";

type SurfaceTone = "surface" | "primaryOutline" | "muted" | "dark";

const tokens = {
  primary: "#6366F1",
  primaryDim: "#3F498A",
  primaryBright: "#C7D2FE",
  primarySoft: "#EEF2FF",
  streak: "#F97316",
  streakDim: "#C2410C",
  backgroundPage: "#F8F9FA",
  backgroundSurface: "#FFFFFF",
  softGray: "#F3F4F6",
  borderNeutralSubtle: "#E5E7EB",
  textPrimary: "#111827",
  textSecondary: "#6B7280",
  textMuted: "#9CA3AF",
  actionSuccess: "#22C55E",
  actionError: "#EF4444",
  ratingAgainBackground: "#FEF2F2",
  ratingAgainText: "#F44336",
  ratingAgainBorder: "#FECACA",
  ratingHardBackground: "#FFF7ED",
  ratingHardText: "#FF9800",
  ratingHardBorder: "#FED7AA",
  ratingGoodBackground: "#F0FDF4",
  ratingGoodText: "#4CAF50",
  ratingGoodBorder: "#BBF7D0",
  ratingEasyBackground: "#EFF6FF",
  ratingEasyText: "#2196F3",
  ratingEasyBorder: "#BFDBFE",
};

const Section = ({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) => (
  <section className="mb-12">
    <h2 className="mb-6 border-b-2 border-gray-200 pb-2 text-[10px] font-black uppercase tracking-[0.2em] text-gray-400">
      {title}
    </h2>
    {children}
  </section>
);

const Surface = ({
  tone = "surface",
  children,
  className = "",
}: {
  tone?: SurfaceTone;
  children: React.ReactNode;
  className?: string;
}) => {
  const toneClass: Record<SurfaceTone, string> = {
    surface: "bg-white border-gray-200 shadow-[0_4px_12px_rgba(229,231,235,0.55)]",
    primaryOutline:
      "bg-white border-indigo-500 shadow-[0_8px_30px_rgba(99,102,241,0.16)]",
    muted: "bg-gray-100 border-gray-200 shadow-[0_4px_12px_rgba(229,231,235,0.55)]",
    dark: "bg-[#3F498A] border-[#3F498A] text-white shadow-[0_8px_20px_rgba(63,73,138,0.35)]",
  };

  return (
    <div className={`rounded-[40px] border-2 p-7 ${toneClass[tone]} ${className}`}>
      {children}
    </div>
  );
};

const TactileButton = ({
  tone = "ghost",
  children,
  icon,
  trailing,
  flat = false,
  selected = false,
  disabled = false,
  full = false,
}: {
  tone?: Tone;
  children?: React.ReactNode;
  icon?: string;
  trailing?: string;
  flat?: boolean;
  selected?: boolean;
  disabled?: boolean;
  full?: boolean;
}) => {
  const toneClass: Record<Tone, string> = {
    filled:
      "bg-indigo-500 text-white border-indigo-500 shadow-[0_6px_0_0_#3F498A] hover:bg-indigo-600",
    ghost:
      "bg-white text-gray-900 border-gray-200 shadow-[0_6px_0_0_#E5E7EB] hover:bg-gray-50",
    text: "bg-transparent text-gray-500 border-transparent shadow-none hover:text-gray-900",
    dashed:
      "bg-gray-100 text-gray-400 border-transparent border-dashed shadow-none hover:text-indigo-500",
    streak:
      "bg-orange-500 text-white border-orange-500 shadow-[0_6px_0_0_#C2410C]",
    success:
      "bg-green-50 text-green-500 border-green-500 shadow-[0_4px_0_0_rgba(34,197,94,0.32)]",
    error:
      "bg-red-50 text-red-500 border-red-500 shadow-[0_4px_0_0_rgba(239,68,68,0.32)]",
    again:
      "bg-red-50 text-[#F44336] border-red-200 shadow-[0_4px_0_0_#FECACA]",
    hard:
      "bg-orange-50 text-[#FF9800] border-orange-200 shadow-[0_4px_0_0_#FED7AA]",
    good:
      "bg-green-50 text-[#4CAF50] border-green-200 shadow-[0_4px_0_0_#BBF7D0]",
    easy:
      "bg-blue-50 text-[#2196F3] border-blue-200 shadow-[0_4px_0_0_#BFDBFE]",
  };
  const depthClass = flat ? "shadow-none" : "";
  const selectedClass = selected ? "border-indigo-300 bg-indigo-50 text-indigo-500" : "";
  const widthClass = full ? "w-full justify-between" : "w-fit";

  return (
    <button
      disabled={disabled}
      className={`btn-tactile flex min-h-12 items-center justify-center gap-2 rounded-2xl border-2 px-6 py-3 text-sm font-extrabold leading-none ${widthClass} ${toneClass[tone]} ${depthClass} ${selectedClass}`}
    >
      {icon && <i className={`${icon} text-base`} />}
      {children && <span>{children}</span>}
      {trailing && <i className={`${trailing} text-base`} />}
    </button>
  );
};

const InfoCard = ({
  icon,
  title,
  body,
  tone,
}: {
  icon: string;
  title: string;
  body: string;
  tone: "primary" | "streak" | "success";
}) => {
  const color = {
    primary: "bg-indigo-50 text-indigo-500",
    streak: "bg-orange-50 text-orange-500",
    success: "bg-green-50 text-green-500",
  }[tone];

  return (
    <Surface>
      <div className={`mb-6 flex h-12 w-12 items-center justify-center rounded-full ${color}`}>
        <i className={`${icon} text-xl`} />
      </div>
      <h3 className="mb-3 text-xl font-black text-gray-900">{title}</h3>
      <p className="text-sm font-semibold leading-relaxed text-gray-500">{body}</p>
    </Surface>
  );
};

const TokenSwatch = ({ name, hex }: { name: string; hex: string }) => (
  <div className="flex flex-col gap-2">
    <div
      className="flex h-24 items-end rounded-3xl border-2 border-gray-200 p-3 shadow-[0_3px_10px_rgba(229,231,235,0.55)]"
      style={{ backgroundColor: hex }}
    >
      <span className="text-[10px] font-black uppercase text-white opacity-70 mix-blend-difference">
        {hex}
      </span>
    </div>
    <div className="px-1">
      <p className="text-sm font-extrabold text-gray-900">{name}</p>
      <p className="text-[10px] font-semibold uppercase text-gray-400">{hex}</p>
    </div>
  </div>
);

const TokenSwatchGroup = ({
  title,
  swatches,
}: {
  title: string;
  swatches: Array<[string, string]>;
}) => (
  <div>
    <h3 className="mb-4 text-[10px] font-black uppercase tracking-[0.2em] text-gray-400">
      {title}
    </h3>
    <div className="grid grid-cols-2 gap-6 md:grid-cols-4 lg:grid-cols-6">
      {swatches.map(([name, hex]) => (
        <TokenSwatch key={name} name={name} hex={hex} />
      ))}
    </div>
  </div>
);

const TypeSpec = ({
  label,
  children,
}: {
  label: string;
  children: React.ReactNode;
}) => (
  <div>
    <p className="mb-2 text-[10px] font-black uppercase tracking-[0.2em] text-gray-400">
      {label}
    </p>
    {children}
  </div>
);

const ButtonGroup = ({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) => (
  <div>
    <h3 className="mb-5 text-[10px] font-black uppercase tracking-[0.2em] text-gray-400">
      {title}
    </h3>
    <div className="flex flex-wrap gap-4">{children}</div>
  </div>
);

const TextFieldSample = ({
  title,
  description,
  children,
}: {
  title: string;
  description: string;
  children: React.ReactNode;
}) => (
  <Surface tone="muted">
    <h3 className="mb-2 text-base font-black text-gray-900">{title}</h3>
    <p className="mb-5 text-sm font-semibold leading-relaxed text-gray-500">{description}</p>
    {children}
  </Surface>
);

const Field = ({
  placeholder,
  frame = "outline",
  tone = "neutral",
  large = false,
  disabled = false,
  strike = false,
}: {
  placeholder: string;
  frame?: "none" | "outline" | "underline";
  tone?: "neutral" | "brand" | "success" | "error";
  large?: boolean;
  disabled?: boolean;
  strike?: boolean;
}) => {
  const toneClass = {
    neutral: "text-gray-900 caret-indigo-500",
    brand: "text-indigo-500 caret-indigo-500",
    success: "text-green-500 caret-green-500",
    error: "text-red-500 caret-red-500",
  }[tone];
  const frameClass = {
    none: "border-0 bg-transparent p-0",
    outline: "rounded-2xl border-2 border-gray-200 bg-[#F8F9FA] p-4 focus:border-indigo-500",
    underline:
      "rounded-xl border-0 border-b-4 border-indigo-500 bg-gray-100 px-5 py-3 text-center focus:border-indigo-500",
  }[frame];
  const stateClass =
    tone === "success"
      ? "bg-green-50 border-green-500"
      : tone === "error"
        ? "bg-red-50 border-red-500"
        : "";

  return (
    <input
      disabled={disabled}
      placeholder={placeholder}
      className={`w-full font-extrabold outline-none disabled:opacity-100 ${large ? "min-h-28 text-3xl" : "text-base"} ${toneClass} ${frameClass} ${stateClass} ${strike ? "line-through" : ""}`}
    />
  );
};

export default function DesignSystem() {
  const navigate = useNavigate();
  const { showNotchMargin } = useSettings();

  return (
    <div
      className={`h-full overflow-y-auto bg-[#F8F9FA] p-8 font-sans antialiased md:p-16 ${
        showNotchMargin ? "pt-10" : "pt-0"
      }`}
    >
      <button
        onClick={() => navigate(-1)}
        className="btn-tactile fixed right-8 top-8 z-50 flex h-12 w-12 items-center justify-center rounded-2xl border-2 border-gray-200 bg-white text-gray-500 shadow-sm hover:bg-gray-50"
      >
        <i className="fa-solid fa-xmark text-xl" />
      </button>

      <main className="mx-auto max-w-7xl">
        <header className="mb-16">
          <div className="mb-4 flex flex-wrap items-center gap-4">
            <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-indigo-500 text-2xl text-white shadow-[0_4px_0_0_#3F498A]">
              <i className="fa-solid fa-wand-magic-sparkles" />
            </div>
            <h1 className="text-4xl font-black leading-none text-gray-900">
              BooMondai <span className="text-indigo-500">Design System</span>
            </h1>
          </div>
          <p className="max-w-2xl text-xl font-semibold leading-relaxed text-gray-500">
            A tactile, low-cognitive-load framework designed for neurodivergent
            learners. Focusing on{" "}
            <span className="font-extrabold text-indigo-500">immediate feedback</span>,{" "}
            <span className="font-extrabold text-indigo-500">spatial consistency</span>, and{" "}
            <span className="font-extrabold text-indigo-500">sensory delight</span>.
          </p>
        </header>

        <Section title="01. Experience Philosophy">
          <div className="grid grid-cols-1 gap-8 md:grid-cols-3">
            <InfoCard
              icon="fa-solid fa-brain"
              title="Reduced Cognitive Load"
              body='We use "Chunking" to prevent overwhelm. Every screen has one primary action. Minimalistic sidebars and clear headers provide constant spatial orientation.'
              tone="primary"
            />
            <InfoCard
              icon="fa-solid fa-fingerprint"
              title="Tactile Feedback"
              body="Buttons have physical depth. When pressed, they move 4px down, mimicking real-world haptics and creating a satisfying sensory loop."
              tone="streak"
            />
            <InfoCard
              icon="fa-solid fa-clock-rotate-left"
              title="Memory Retrieval"
              body="Color-coded FSRS ratings help map abstract memory states to concrete visual cues, accelerating spaced repetition learning."
              tone="success"
            />
          </div>
        </Section>

        <Section title="02. Color Palette">
          <div className="space-y-8">
            <TokenSwatchGroup
              title="Brand"
              swatches={[
                ["primary", tokens.primary],
                ["primaryDim", tokens.primaryDim],
                ["primaryBright", tokens.primaryBright],
                ["primarySoft", tokens.primarySoft],
                ["streak", tokens.streak],
                ["streakDim", tokens.streakDim],
              ]}
            />
            <TokenSwatchGroup
              title="Surface & Text"
              swatches={[
                ["backgroundPage", tokens.backgroundPage],
                ["backgroundSurface", tokens.backgroundSurface],
                ["softGray", tokens.softGray],
                ["borderNeutralSubtle", tokens.borderNeutralSubtle],
                ["textPrimary", tokens.textPrimary],
                ["textSecondary", tokens.textSecondary],
                ["textMuted", tokens.textMuted],
              ]}
            />
            <TokenSwatchGroup
              title="Actions"
              swatches={[
                ["actionSuccess", tokens.actionSuccess],
                ["actionError", tokens.actionError],
              ]}
            />
            <TokenSwatchGroup
              title="Ratings"
              swatches={[
                ["ratingAgainBackground", tokens.ratingAgainBackground],
                ["ratingAgainText", tokens.ratingAgainText],
                ["ratingAgainBorder", tokens.ratingAgainBorder],
                ["ratingHardBackground", tokens.ratingHardBackground],
                ["ratingHardText", tokens.ratingHardText],
                ["ratingHardBorder", tokens.ratingHardBorder],
                ["ratingGoodBackground", tokens.ratingGoodBackground],
                ["ratingGoodText", tokens.ratingGoodText],
                ["ratingGoodBorder", tokens.ratingGoodBorder],
                ["ratingEasyBackground", tokens.ratingEasyBackground],
                ["ratingEasyText", tokens.ratingEasyText],
                ["ratingEasyBorder", tokens.ratingEasyBorder],
              ]}
            />
          </div>
        </Section>

        <Section title="03. Typography">
          <Surface>
            <div className="space-y-8">
              <TypeSpec label="TextSize.header + TextWeight.heavy + TextTone.primary">
                <h2 className="text-2xl font-black leading-tight text-gray-900">
                  Learning Made Tactile
                </h2>
              </TypeSpec>
              <TypeSpec label="TextSize.labelLarge + TextWeight.heavy + TextTone.primary">
                <p className="text-base font-black leading-tight text-gray-900">
                  Ready for your review?
                </p>
              </TypeSpec>
              <TypeSpec label="TextSize.label + TextWeight.body + TextTone.secondary">
                <p className="text-sm font-semibold leading-relaxed text-gray-500">
                  The quick brown flashcard uses label text for compact supporting copy.
                </p>
              </TypeSpec>
              <TypeSpec label="TextSize.labelSmall + TextWeight.heavy + TextTone.muted">
                <p className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-400">
                  Eyebrow Label
                </p>
              </TypeSpec>
              <TypeSpec label="TextSize.bodyLarge + TextWeight.strong + TextTone.primary">
                <p className="text-3xl font-extrabold leading-tight text-gray-900">
                  図書館 (Library)
                </p>
              </TypeSpec>
            </div>
          </Surface>
        </Section>

        <Section title="04. Surface Variants">
          <div className="grid grid-cols-1 gap-6 md:grid-cols-2 xl:grid-cols-4">
            <Surface tone="surface">
              <h3 className="mb-3 text-base font-black text-gray-900">SurfaceTone.surface</h3>
              <p className="text-sm font-semibold text-gray-500">Default panel surface.</p>
            </Surface>
            <Surface tone="primaryOutline">
              <h3 className="mb-3 text-base font-black text-gray-900">
                SurfaceTone.primaryOutline
              </h3>
              <p className="text-sm font-semibold text-gray-500">
                White card with primary outline.
              </p>
            </Surface>
            <Surface tone="muted">
              <h3 className="mb-3 text-base font-black text-gray-900">SurfaceTone.muted</h3>
              <p className="text-sm font-semibold text-gray-500">Soft inset grouping surface.</p>
            </Surface>
            <Surface tone="dark">
              <h3 className="mb-3 text-base font-black text-white">SurfaceTone.dark</h3>
              <p className="text-sm font-semibold text-white/80">High-emphasis dark surface.</p>
            </Surface>
          </div>
        </Section>

        <Section title="05. The Button Lab">
          <div className="grid grid-cols-1 gap-8 md:grid-cols-2">
            <ButtonGroup title="TactileTone">
              <TactileButton tone="filled" icon="fa-solid fa-play">
                TactileTone.filled
              </TactileButton>
              <TactileButton tone="ghost" icon="fa-solid fa-layer-group">
                TactileTone.ghost
              </TactileButton>
              <TactileButton tone="text" icon="fa-solid fa-link">
                TactileTone.text
              </TactileButton>
              <TactileButton tone="dashed" icon="fa-solid fa-plus">
                TactileTone.dashed
              </TactileButton>
              <TactileButton tone="streak" icon="fa-solid fa-fire">
                TactileTone.streak
              </TactileButton>
            </ButtonGroup>

            <ButtonGroup title="Rating TactileTone">
              <TactileButton tone="again" icon="fa-solid fa-rotate-left">
                TactileTone.again
              </TactileButton>
              <TactileButton tone="hard" icon="fa-solid fa-exclamation">
                TactileTone.hard
              </TactileButton>
              <TactileButton tone="good" icon="fa-solid fa-check">
                TactileTone.good
              </TactileButton>
              <TactileButton tone="easy" icon="fa-solid fa-bolt">
                TactileTone.easy
              </TactileButton>
            </ButtonGroup>

            <ButtonGroup title="Feedback TactileTone">
              <TactileButton tone="success" icon="fa-solid fa-circle-check">
                TactileTone.success
              </TactileButton>
              <TactileButton tone="error" icon="fa-solid fa-circle-xmark">
                TactileTone.error
              </TactileButton>
              <TactileButton tone="error" flat disabled>
                TactileTone.error + TactileDepth.flat
              </TactileButton>
            </ButtonGroup>

            <ButtonGroup title="TactileState + TactileDepth">
              <TactileButton selected icon="fa-solid fa-star">
                TactileState.selected
              </TactileButton>
              <TactileButton disabled icon="fa-solid fa-ban">
                TactileState.disabled
              </TactileButton>
              <TactileButton tone="filled" flat>
                TactileDepth.flat
              </TactileButton>
              <TactileButton flat icon="fa-solid fa-circle-dot">
                TactileDepth.flat + TactileTone.ghost
              </TactileButton>
            </ButtonGroup>

            <ButtonGroup title="TactileSize">
              <TactileButton icon="fa-solid fa-text-height">TactileSize.sm</TactileButton>
              <TactileButton icon="fa-solid fa-text-height">TactileSize.md</TactileButton>
              <TactileButton icon="fa-solid fa-text-height">TactileSize.lg</TactileButton>
              <TactileButton icon="fa-solid fa-gear" />
            </ButtonGroup>

            <ButtonGroup title="TactileButton Layout Props">
              <TactileButton full icon="fa-solid fa-align-left" trailing="fa-solid fa-chevron-right">
                leading + trailing + start
              </TactileButton>
              <TactileButton full icon="fa-solid fa-align-center">
                mainAxisAlignment.center
              </TactileButton>
              <TactileButton full icon="fa-solid fa-arrows-left-right" trailing="fa-solid fa-angle-down">
                mainAxisAlignment.spaceBetween
              </TactileButton>
              <TactileButton icon="fa-solid fa-compress">mainAxisSize.min</TactileButton>
            </ButtonGroup>
          </div>
        </Section>

        <Section title="06. Text Field Variants">
          <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
            <TextFieldSample
              title="AppTextFieldFrame.none + AppTextFieldSize.bodyLarge"
              description="TextFieldCard content style."
            >
              <Surface>
                <Field
                  frame="none"
                  large
                  placeholder="私は毎日図書館で勉強します。"
                />
              </Surface>
            </TextFieldSample>
            <TextFieldSample
              title="AppTextFieldFrame.outline + AppTextFieldSize.labelLarge"
              description="Matching input and compact editable rows."
            >
              <Field placeholder="Term or answer" />
            </TextFieldSample>
            <TextFieldSample
              title="AppTextFieldFrame.underline + AppTextFieldTone.brand"
              description="Fill-in-the-blank active answer field."
            >
              <div className="max-w-[260px]">
                <Field frame="underline" tone="brand" placeholder="図書館" />
              </div>
            </TextFieldSample>
            <TextFieldSample
              title="AppTextFieldFrame.underline + AppTextFieldTone.success"
              description="Revealed correct answer state."
            >
              <div className="max-w-[260px]">
                <Field frame="underline" tone="success" placeholder="Correct answer" disabled />
              </div>
            </TextFieldSample>
            <TextFieldSample
              title="AppTextFieldTone.error + AppTextFieldState.incorrect"
              description="Revealed incorrect answer state."
            >
              <div className="max-w-[260px]">
                <Field frame="underline" tone="error" placeholder="Wrong answer" disabled strike />
              </div>
            </TextFieldSample>
          </div>
        </Section>

        <Section title="08. Accessibility & Flutter Roadmap">
          <Surface tone="dark" className="space-y-6">
            <h3 className="text-2xl font-black text-white">Device Level Integrations</h3>
            <ul className="space-y-4 text-sm font-semibold leading-relaxed text-white/90">
              <li>
                <span className="font-black text-white">Haptic Engine:</span> Every tactile
                button should trigger a native vibration pattern.
              </li>
              <li>
                <span className="font-black text-white">Sensory Safety:</span> Add a Soft
                Mode toggle that reduces contrast and motion.
              </li>
              <li>
                <span className="font-black text-white">Dyslexia Support:</span> Include a
                toggle for OpenDyslexic or a similar typeface.
              </li>
            </ul>
          </Surface>
        </Section>
      </main>
    </div>
  );
}
