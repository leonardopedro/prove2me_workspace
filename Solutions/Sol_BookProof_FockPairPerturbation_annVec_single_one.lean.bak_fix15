-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.annVec_single_one
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_annVec_apply
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (w : FockAlg) :
    annVec (Finsupp.single k (1 : ℂ)) w = annA k w := by

  classical
  rw [annVec_apply, Finsupp.support_single_ne_zero k one_ne_zero]
  simp
