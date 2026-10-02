-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.summable_crossB
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_norm_crossB
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution {X Y : ι → ℂ}
    (hX : Summable fun β => (S.ampSeq X β) ^ 2) (hY : Summable fun β => ‖Y β‖ ^ 2) :
    Summable (S.crossB X Y) := by

  refine Summable.of_norm (Summable.of_nonneg_of_le (fun β => norm_nonneg _) (fun β => ?_)
    (((summable_comp_shift S hX).add hY).mul_left (1 / 2)))
  rw [norm_crossB S]
  have hmono : S.amp β * ‖X (S.shift β)‖ ≤ S.ampSeq X (S.shift β) :=
    mul_le_mul_of_nonneg_right (S.amp_mono β) (norm_nonneg _)
  have h0 : 0 ≤ ‖Y β‖ := norm_nonneg _
  nlinarith [sq_nonneg (S.ampSeq X (S.shift β) - ‖Y β‖), ampSeq_nonneg S X (S.shift β),
    mul_le_mul_of_nonneg_right hmono h0]
