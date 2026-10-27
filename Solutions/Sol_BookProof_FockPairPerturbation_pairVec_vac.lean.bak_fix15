-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.pairVec_vac
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_pairVec_apply
import Theorems.Thm_BookProof_FockPairPerturbation_annVec_vac
import Theorems.Thm_BookProof_FockPairPerturbation_creVec_single_one
import Theorems.Thm_BookProof_FockSecondQuantization_creA_single
import Theorems.Thm_BookProof_FockSecondQuantization_up_of_ne
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) :
    pairVec (Finsupp.single k 1) (Finsupp.single k 1) vac
      = Finsupp.single (Finsupp.single k 2) ((Real.sqrt 2 : ℝ) : ℂ) := by

  classical
  have hup0 : up k (0 : Conf) = Finsupp.single k 1 := by
    refine Finsupp.ext fun i => ?_
    rcases eq_or_ne i k with rfl | h
    · simp [up]
    · rw [up_of_ne _ h]; simp [h]
  have hup1 : up k (Finsupp.single k (1 : ℕ)) = Finsupp.single k 2 := by
    refine Finsupp.ext fun i => ?_
    rcases eq_or_ne i k with rfl | h
    · simp [up]
    · rw [up_of_ne _ h]; simp [h]
  rw [pairVec_apply, annVec_vac, map_zero, add_zero, creVec_single_one, creVec_single_one,
    vac, creA_single, one_smul, hup0, creA_single, hup1]
  norm_num
