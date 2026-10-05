-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.super_canonical
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_liftFst_mul
import Theorems.Thm_BookProof_GradedFock_liftSnd_mul
import Theorems.Thm_BookProof_GradedFock_liftFst_one
import Theorems.Thm_BookProof_GradedFock_liftSnd_one
import Theorems.Thm_BookProof_GradedFock_liftSnd_add
import Theorems.Thm_BookProof_GradedFock_liftFst_sub
import Theorems.Thm_BookProof_GradedFock_liftFst_zero
import Theorems.Thm_BookProof_GradedFock_liftSnd_zero
import Theorems.Thm_BookProof_GradedFock_liftFst_liftSnd_comm
import Theorems.Thm_BookProof_GradedFock_annA_creA_end
import Theorems.Thm_BookProof_GradedFock_annA_creA_end_of_ne
import Theorems.Thm_BookProof_GradedFock_annF_creF_end
import Theorems.Thm_BookProof_GradedFock_annF_creF_end_of_ne
import Theorems.Thm_BookProof_GradedFock_sbracket_even_odd
import Theorems.Thm_BookProof_GradedFock_sbracket_odd_even
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution (p q : Bool) (j k : ℕ) :
    sbracket p q (gAnn p j) (gCre q k) = if p = q ∧ j = k then 1 else 0 := by

  cases p <;> cases q <;>
    simp only [gAnn, gCre, bann, bcre, fann, fcre, sbracket_even_even,
      sbracket_even_odd, sbracket_odd_even, sbracket_odd_odd]
  · -- bosonic / bosonic
    rcases eq_or_ne j k with rfl | h
    · rw [liftFst_mul, liftFst_mul, ← liftFst_sub, annA_creA_end, liftFst_one,
        if_pos (by simp)]
    · rw [liftFst_mul, liftFst_mul, ← liftFst_sub, annA_creA_end_of_ne h, liftFst_zero,
        if_neg (by simp [h])]
  · -- bosonic / fermionic
    rw [liftFst_liftSnd_comm, sub_self]
    simp
  · -- fermionic / bosonic
    rw [← liftFst_liftSnd_comm, sub_self]
    simp
  · -- fermionic / fermionic
    rcases eq_or_ne j k with rfl | h
    · rw [liftSnd_mul, liftSnd_mul, ← liftSnd_add, annF_creF_end, liftSnd_one,
        if_pos (by simp)]
    · rw [liftSnd_mul, liftSnd_mul, ← liftSnd_add, annF_creF_end_of_ne h, liftSnd_zero,
        if_neg (by simp [h])]
