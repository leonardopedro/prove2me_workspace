-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.lc1_shift
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

theorem BookProof.CarlemanTwoStep.lc1_shift (i : Fin d) (a : Fin d →₀ ℕ) :
    lc1 (a + Finsupp.single i 1) i = rc1 a i := by sorry
