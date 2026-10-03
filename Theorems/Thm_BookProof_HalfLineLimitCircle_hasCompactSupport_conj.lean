-- Generated from ChapterHalfLineLimitCircle.lean — theorem BookProof.HalfLineLimitCircle.hasCompactSupport_conj
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Definitions.Def_ChapterA4



open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

theorem BookProof.HalfLineLimitCircle.hasCompactSupport_conj {f : ℝ → ℂ} (hf : HasCompactSupport f) :
    HasCompactSupport fun x => (starRingEnd ℂ) (f x) := by sorry
