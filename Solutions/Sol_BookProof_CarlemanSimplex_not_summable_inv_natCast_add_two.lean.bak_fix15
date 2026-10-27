-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.not_summable_inv_natCast_add_two
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Theorems.Thm_BookProof_CarlemanTwoStep_not_summable_inv_natCast_succ
open BookProof.CarlemanSimplex




open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}

set_option maxHeartbeats 1000000 in
theorem solution : ¬ Summable (fun N : ℕ => ((N : ℝ) + 2)⁻¹) := by

  intro h
  refine not_summable_inv_natCast_succ ?_
  refine (summable_nat_add_iff 1).mp ?_
  refine h.congr fun N => ?_
  push_cast
  ring_nf
