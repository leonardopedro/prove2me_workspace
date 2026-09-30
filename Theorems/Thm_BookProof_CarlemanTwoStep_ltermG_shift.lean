-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.ltermG_shift
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep










open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}











variable {u : (Fin d →₀ ℕ) → ℂ}

theorem BookProof.CarlemanTwoStep.ltermG_shift {w : ℂ} {rc lc : (Fin d →₀ ℕ) → Fin d → ℝ} {k : ℕ} {i : Fin d}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + Finsupp.single i k) i = rc a i) (b : Fin d →₀ ℕ) :
    ltermG u w lc k i (b + Finsupp.single i k) = (starRingEnd ℂ) (rtermG u w rc k i b) := by sorry
