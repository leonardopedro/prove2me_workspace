-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.lc2_vanish
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

theorem BookProof.CarlemanTwoStep.lc2_vanish (i : Fin d) (a : Fin d →₀ ℕ) (h : a i < 2) : lc2 a i = 0 := by sorry
