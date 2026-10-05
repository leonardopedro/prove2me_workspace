-- Generated from ChapterFockNumberPreservingGap.lean — solution of BookProof.FockNumberPreservingGap.creVec_smul
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Theorems.Thm_BookProof_FockNumberPreservingGap_creVec_eq_sum_of_subset
import Theorems.Thm_BookProof_FockSecondQuantization_creVec_apply
open BookProof.FockNumberPreservingGap



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (v : ℕ →₀ ℂ) (x : FockAlg) :
    creVec (c • v) x = c • creVec v x := by

  classical
  have h1 : (c • v).support ⊆ v.support := Finsupp.support_smul
  rw [creVec_eq_sum_of_subset _ _ h1, creVec_apply, Finset.smul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finsupp.smul_apply, smul_eq_mul, mul_smul]
