-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.sum_hEx_vEx
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_vEx_apply
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift











open FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {d : ℕ} (c : ComparisonData F d)











open LpNat DiagonalEsa









variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}















open EuclideanSpace

set_option maxHeartbeats 1000000 in
theorem solution :
    (hEx 0 + hEx 1) vEx = (2 : ℂ) • EuclideanSpace.single (0 : Fin 2) (1 : ℂ) := by

  simp only [LinearMap.add_apply, hEx, LinearMap.smulRight_apply, ← add_smul]
  rw [show (EuclideanSpace.projₗ (𝕜 := ℂ) (0 : Fin 2)) vEx = vEx 0 from rfl,
    show (EuclideanSpace.projₗ (𝕜 := ℂ) (1 : Fin 2)) vEx = vEx 1 from rfl,
    vEx_apply, vEx_apply]
  norm_num
