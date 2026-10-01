-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.not_summable_inv_natCast_add_two
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

theorem BookProof.CarlemanSimplex.not_summable_inv_natCast_add_two : ¬ Summable (fun N : ℕ => ((N : ℝ) + 2)⁻¹) := by sorry
