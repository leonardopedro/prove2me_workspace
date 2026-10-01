-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.norm_crossB
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) (X Y : ℕ → ℂ) (n : ℕ) :
    ‖crossB κ X Y n‖ = amp κ n * ‖X (n + 2)‖ * ‖Y n‖ := by

  simp only [crossB, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (amp_nonneg hκ n), RCLike.norm_conj]
