-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.summable_crossA
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_norm_crossA
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution {X Y : ι → ℂ}
    (hX : Summable fun β => (S.ampSeq X β) ^ 2) (hY : Summable fun β => ‖Y β‖ ^ 2) :
    Summable (S.crossA X Y) := by

  refine Summable.of_norm (Summable.of_nonneg_of_le (fun β => norm_nonneg _) (fun β => ?_)
    ((hX.add (summable_comp_shift S hY)).mul_left (1 / 2)))
  rw [norm_crossA S]
  nlinarith [sq_nonneg (S.ampSeq X β - ‖Y (S.shift β)‖), ampSeq_nonneg S X β,
    norm_nonneg (Y (S.shift β))]
