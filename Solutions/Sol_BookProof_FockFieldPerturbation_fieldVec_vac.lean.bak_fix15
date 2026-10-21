-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.fieldVec_vac
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_annVec_apply
import Theorems.Thm_BookProof_FockFieldPerturbation_fieldVec_apply
import Theorems.Thm_BookProof_FockSecondQuantization_annA_single
import Theorems.Thm_BookProof_FockSecondQuantization_creA_single
import Theorems.Thm_BookProof_FockSecondQuantization_creVec_apply
import Theorems.Thm_BookProof_FockSecondQuantization_up_of_ne
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) :
    fieldVec (Finsupp.single k 1) vac = Finsupp.single (Finsupp.single k 1) (1 : ℂ) := by

  classical
  have hup : up k (0 : Conf) = Finsupp.single k 1 := by
    refine Finsupp.ext fun i => ?_
    rcases eq_or_ne i k with h | h
    · subst h; simp [up]
    · rw [up_of_ne _ h]
      simp [h]
  have hsupp : (Finsupp.single k (1 : ℂ)).support = {k} :=
    Finsupp.support_single_ne_zero k one_ne_zero
  rw [fieldVec_apply, creVec_apply, annVec_apply, hsupp]
  simp [vac, hup]
