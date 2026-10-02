-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.hasSum_inner_shiftH_right
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_shiftH_coe
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_summable_crossA
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_summable_crossB
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_conj_mul_hFun
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_summable_normSq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution (x y : maxDom S.sym) :
    HasSum (fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ)) β
        + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ)) β)
      (inner ℂ (x : L2I ι) (shiftH S y : L2I ι)) := by

  have hA := summable_crossA S (Y := ((y : L2I ι) : ι → ℂ)) (summable_ampSeq_sq S x)
    (summable_normSq (y : L2I ι))
  have hB := summable_crossB S (Y := ((y : L2I ι) : ι → ℂ)) (summable_ampSeq_sq S x)
    (summable_normSq (y : L2I ι))
  have hgoal := (hA.hasSum.mul_left (-Complex.I)).add (hB.hasSum.mul_left Complex.I)
  have hshift := (hA.hasSum.mul_left (-Complex.I)).add
    (((hasSum_hop_iff S).mpr hB.hasSum).mul_left Complex.I)
  have hinner := lp.hasSum_inner (𝕜 := ℂ) ((x : L2I ι)) ((shiftH S y : L2I ι))
  have heq : (fun β => (inner ℂ (((x : L2I ι) : ι → ℂ) β)
        (((shiftH S y : L2I ι) : ι → ℂ) β) : ℂ))
      = fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ)) β
          + Complex.I * S.hop (S.crossB ((x : L2I ι) : ι → ℂ) (((y : L2I ι) : ι → ℂ))) β := by
    funext β
    rw [RCLike.inner_apply, shiftH_coe, mul_comm]
    exact conj_mul_hFun S _ _ β
  rw [heq] at hinner
  rwa [hshift.unique hinner] at hgoal
