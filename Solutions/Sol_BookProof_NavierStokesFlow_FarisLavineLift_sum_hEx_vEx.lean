-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.sum_hEx_vEx
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_vEx_apply
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

set_option maxHeartbeats 1000000 in
: Fin 2) (1 : ℂ)

theorem solution (i : Fin 2) : vEx i = 1 := by
  fin_cases i <;> simp [vEx, Euclidean :=
  Space.single_apply]
  
  theorem norm_vEx_sq : ‖vEx‖ ^ 2 = 2 := by
    rw [EuclideanSpace.norm_eq, Real.sq_sqrt (by positivity)]
    simp [vEx_apply]
  
  theorem sum_nEx_vEx : (nEx 0 + nEx 1) vEx = vEx := by
    simp [nEx, vEx]
  
  theorem sum_hEx_vEx :
      (hEx 0 + hEx 1) vEx = (2 : ℂ) • Euclid
