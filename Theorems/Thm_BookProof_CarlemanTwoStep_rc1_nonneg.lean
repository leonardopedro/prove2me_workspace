-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.rc1_nonneg
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

theorem BookProof.CarlemanTwoStep.rc1_nonneg (a : Fin d →₀ ℕ) (i : Fin d) : 0 ≤ rc1 a i := by sorry
