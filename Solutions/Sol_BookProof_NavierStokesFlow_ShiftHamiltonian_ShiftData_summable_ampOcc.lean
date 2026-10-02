-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.summable_ampOcc
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_amp_le_symbol
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_hasSum_quadForm
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution (x : maxDom S.sym) :
    Summable (fun β => S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2) := by

  refine Summable.of_nonneg_of_le (fun β => mul_nonneg (S.amp_nonneg β) (sq_nonneg _))
    (fun β => ?_) ((diagMax_hasSum_quadForm S.sym x).summable.mul_left (1 / 4 + S.K))
  nlinarith [amp_le_symbol S β, sq_nonneg ‖((x : L2I ι) : ι → ℂ) β‖]
