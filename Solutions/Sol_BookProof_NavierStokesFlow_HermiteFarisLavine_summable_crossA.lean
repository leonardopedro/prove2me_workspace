-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.summable_crossA
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_norm_crossA
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) {X Y : ℕ → ℂ}
    (hX : Summable fun n => (ampSeq κ X n) ^ 2) (hY : Summable fun n => ‖Y n‖ ^ 2) :
    Summable (crossA κ X Y) := by

  refine Summable.of_norm (Summable.of_nonneg_of_le (fun n => norm_nonneg _) (fun n => ?_)
    ((hX.add ((summable_nat_add_iff 2).mpr hY)).mul_left (1 / 2)))
  rw [norm_crossA hκ]
  nlinarith [sq_nonneg (ampSeq κ X n - ‖Y (n + 2)‖), ampSeq_nonneg hκ X n, norm_nonneg (Y (n + 2))]
