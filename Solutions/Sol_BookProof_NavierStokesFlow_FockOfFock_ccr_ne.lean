-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.ccr_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_annih_coe
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_creat_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock









open FullEsa



variable {ι : Type*}














variable {ι : Type*}











variable {M : Type*} [DecidableEq M]

set_option maxHeartbeats 1000000 in
theorem solution {m m' : M} (h : m ≠ m') :
    (annih m).comp (creat m') - (creat m').comp (annih m) = 0 := by

  ext f n
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.zero_apply,
    Submodule.coe_sub, Pi.sub_apply, annih_coe, creat_coe, lp.coeFn_sub, Submodule.coe_zero,
    lp.coeFn_zero, Pi.zero_apply]
  have hm' : ((n + Finsupp.single m 1 : Conf M) m' : ℝ) = (n m' : ℝ) := by
    simp [Ne.symm h]
  have hm : ((n - Finsupp.single m' 1 : Conf M) m : ℝ) + 1 = (n m : ℝ) + 1 := by
    simp [h]
  have harg : (n + Finsupp.single m 1 : Conf M) - Finsupp.single m' 1
      = (n - Finsupp.single m' 1 : Conf M) + Finsupp.single m 1 := by
    ext j
    rcases eq_or_ne j m with rfl | hj
    · simp [Ne.symm h]
    · rcases eq_or_ne j m' with rfl | hj'
      · simp [hj]
      · simp [Ne.symm hj, Ne.symm hj']
  rw [hm', hm, harg]
  ring
