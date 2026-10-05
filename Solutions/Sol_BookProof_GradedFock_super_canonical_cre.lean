-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.super_canonical_cre
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_liftFst_mul
import Theorems.Thm_BookProof_GradedFock_liftSnd_mul
import Theorems.Thm_BookProof_GradedFock_liftSnd_add
import Theorems.Thm_BookProof_GradedFock_liftFst_sub
import Theorems.Thm_BookProof_GradedFock_liftFst_zero
import Theorems.Thm_BookProof_GradedFock_liftSnd_zero
import Theorems.Thm_BookProof_GradedFock_liftFst_liftSnd_comm
import Theorems.Thm_BookProof_GradedFock_creA_creA_end
import Theorems.Thm_BookProof_GradedFock_creF_creF_end
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
    sbracket p q (gCre p j) (gCre q k) = 0 := by

  cases p <;> cases q <;>
    simp only [gCre, bcre, fcre, sbracket_even_even, sbracket_even_odd,
      sbracket_odd_even, sbracket_odd_odd]
  · rw [liftFst_mul, liftFst_mul, ← liftFst_sub, creA_creA_end, liftFst_zero]
  · rw [liftFst_liftSnd_comm, sub_self]
  · rw [← liftFst_liftSnd_comm, sub_self]
  · rw [liftSnd_mul, liftSnd_mul, ← liftSnd_add, creF_creF_end, liftSnd_zero]
