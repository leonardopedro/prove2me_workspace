-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.annVec_vac
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_annVec_apply
import Theorems.Thm_BookProof_FockSecondQuantization_annA_single
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (f : ℕ →₀ ℂ) : annVec f vac = 0 := by

  classical
  rw [annVec_apply]
  refine Finset.sum_eq_zero fun j _ => ?_
  rw [vac, annA_single]
  simp
