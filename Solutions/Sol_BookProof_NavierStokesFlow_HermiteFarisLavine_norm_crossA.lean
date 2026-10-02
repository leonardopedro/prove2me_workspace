-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.norm_crossA
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) (X Y : ℕ → ℂ) (n : ℕ) :
    ‖crossA κ X Y n‖ = ampSeq κ X n * ‖Y (n + 2)‖ := by

  simp only [crossA, ampSeq, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (amp_nonneg hκ n), RCLike.norm_conj]
