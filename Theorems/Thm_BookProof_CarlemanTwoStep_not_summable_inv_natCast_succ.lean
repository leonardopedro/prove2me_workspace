-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.not_summable_inv_natCast_succ
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep










open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}











variable {u : (Fin d →₀ ℕ) → ℂ}


















variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}

theorem BookProof.CarlemanTwoStep.not_summable_inv_natCast_succ : ¬ Summable (fun N : ℕ => ((N : ℝ) + 1)⁻¹) := by sorry
