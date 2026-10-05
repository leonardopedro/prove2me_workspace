-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hasCompactSupport_conj
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution {f : ℝ → ℂ} (hf : HasCompactSupport f) :
    HasCompactSupport fun x => (starRingEnd ℂ) (f x) := hf.comp_left (g := fun z : ℂ => (starRingEnd ℂ) z) (by simp)
