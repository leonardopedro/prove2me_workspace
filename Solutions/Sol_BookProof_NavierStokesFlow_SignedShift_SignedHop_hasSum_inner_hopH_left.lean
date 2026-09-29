-- Generated from ChapterNavierStokesSignedShift.lean — solution of BookProof.NavierStokesFlow.SignedShift.SignedHop.hasSum_inner_hopH_left
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_hopH_coe
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_summable_crossA
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_summable_crossB
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_conj_hFun_mul
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift
open BookProof.NavierStokesFlow.SignedShift.SignedHop










open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.ShiftHamiltonian BookProof.NavierStokesFlow.AffineFiber

variable {ι : Type*}



variable {sym : ι → ℝ} (S : SignedHop ι sym)

set_option maxHeartbeats 1000000 in
theorem solution (x : maxDom sym) (y : L2I ι) :
    HasSum (fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β
        + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β)
      (inner ℂ (hopH S x : L2I ι) y) := by

  have hA := summable_crossA S (Y := (y : ι → ℂ)) (ShiftData.summable_ampSeq_sq S.maj x)
    (summable_normSq y)
  have hB := summable_crossB S (Y := (y : ι → ℂ)) (ShiftData.summable_ampSeq_sq S.maj x)
    (summable_normSq y)
  have hgoal := (hA.hasSum.mul_left (-Complex.I)).add (hB.hasSum.mul_left Complex.I)
  have hshift := (((ShiftData.hasSum_hop_iff S.maj).mpr hA.hasSum).mul_left (-Complex.I)).add
    (hB.hasSum.mul_left Complex.I)
  have hinner := lp.hasSum_inner (𝕜 := ℂ) ((hopH S x : L2I ι)) y
  have heq : (fun β => (inner ℂ (((hopH S x : L2I ι) : ι → ℂ) β) ((y : ι → ℂ) β) : ℂ))
      = fun β => -Complex.I * S.maj.hop (S.crossA ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ))) β
          + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β := by
    funext β
    rw [RCLike.inner_apply, hopH_coe, mul_comm]
    exact conj_hFun_mul S _ _ β
  rw [heq] at hinner
  rwa [hshift.unique hinner] at hgoal
