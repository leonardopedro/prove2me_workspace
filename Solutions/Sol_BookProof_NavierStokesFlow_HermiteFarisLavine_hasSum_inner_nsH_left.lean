-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.hasSum_inner_nsH_left
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_nsH_coe
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_summable_crossA
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_summable_crossB
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_conj_hFun_mul
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_summable_normSq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) (y : L2I ℕ) :
    HasSum (fun n => -Complex.I * crossA κ ((x : L2I ℕ) : ℕ → ℂ) ((y : ℕ → ℂ)) n
        + Complex.I * crossB κ ((x : L2I ℕ) : ℕ → ℂ) ((y : ℕ → ℂ)) n)
      (inner ℂ (nsH κ hκ x : L2I ℕ) y) := by

  have hA := summable_crossA (Y := (y : ℕ → ℂ)) hκ (summable_ampSeq_sq hκ x) (summable_normSq y)
  have hB := summable_crossB (Y := (y : ℕ → ℂ)) hκ (summable_ampSeq_sq hκ x) (summable_normSq y)
  have hgoal := (hA.hasSum.mul_left (-Complex.I)).add (hB.hasSum.mul_left Complex.I)
  have hshift := ((hasSum_shift2_iff.mpr hA.hasSum).mul_left (-Complex.I)).add
    (hB.hasSum.mul_left Complex.I)
  have hinner := lp.hasSum_inner (𝕜 := ℂ) ((nsH κ hκ x : L2I ℕ)) y
  have heq : (fun m => (inner ℂ (((nsH κ hκ x : L2I ℕ) : ℕ → ℂ) m) ((y : ℕ → ℂ) m) : ℂ))
      = fun m => -Complex.I * shift2 (crossA κ ((x : L2I ℕ) : ℕ → ℂ) ((y : ℕ → ℂ))) m
          + Complex.I * crossB κ ((x : L2I ℕ) : ℕ → ℂ) ((y : ℕ → ℂ)) m := by
    funext m
    rw [RCLike.inner_apply, nsH_coe, mul_comm]
    exact conj_hFun_mul κ _ _ m
  rw [heq] at hinner
  rwa [hshift.unique hinner] at hgoal
