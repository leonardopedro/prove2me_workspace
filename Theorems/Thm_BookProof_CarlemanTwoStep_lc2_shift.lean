-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.lc2_shift
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep










open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}











variable {u : (Fin d →₀ ℕ) → ℂ}

theorem BookProof.CarlemanTwoStep.lc2_shift (i : Fin d) (a : Fin d →₀ ℕ) :
    lc2 (a + Finsupp.single i 2) i = rc2 a i := by sorry
