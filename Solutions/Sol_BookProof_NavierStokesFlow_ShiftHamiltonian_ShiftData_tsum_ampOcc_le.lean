-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.tsum_ampOcc_le
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_amp_le_symbol
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_summable_ampOcc
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_hasSum_quadForm
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution (x : maxDom S.sym) :
    (∑' β, S.amp β * ‖((x : L2I ι) : ι → ℂ) β‖ ^ 2)
      ≤ (1 / 4 + S.K) * quadForm (diagMax S.sym) x := by

  have hq := diagMax_hasSum_quadForm S.sym x
  refine le_trans (Summable.tsum_le_tsum (fun β => ?_) (summable_ampOcc S x)
    (hq.summable.mul_left (1 / 4 + S.K))) ?_
  · nlinarith [amp_le_symbol S β, sq_nonneg ‖((x : L2I ι) : ι → ℂ) β‖]
  · exact le_of_eq (hq.mul_left (1 / 4 + S.K)).tsum_eq
