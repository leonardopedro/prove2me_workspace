-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.lambda_omega_mem_delta
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaA0
import Theorems.Thm_BookProof_ChapterA3_lambdaOf_omegaA0
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaA5
import Theorems.Thm_BookProof_ChapterA3_lambdaOf_omegaA5
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaG05
import Theorems.Thm_BookProof_ChapterA3_lambdaOf_omegaG05
import Theorems.Thm_BookProof_ChapterA3_isPin_one
import Theorems.Thm_BookProof_ChapterA3_lambdaOf_one
import Theorems.Thm_BookProof_ChapterA3_lambdaOf_neg
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ∀ S ∈ OmegaPin, LambdaOf S ∈ LorentzDelta := by

  intro S hS
  simp only [OmegaPin, Set.mem_insert_iff, Set.mem_singleton_iff] at hS
  have hneg1 : LambdaOf (-1 : Matrix (Fin 4) (Fin 4) ℝ) = 1 := by
    have hh := lambdaOf_neg isPin_one
    rw [lambdaOf_one] at hh
    simpa using hh
  rcases hS with h | h | h | h | h | h | h | h <;> subst h
  · rw [lambdaOf_one]; left; rfl
  · rw [hneg1]; left; rfl
  · rw [lambdaOf_omegaA0]; right; left; rfl
  · rw [lambdaOf_neg isPin_omegaA0, lambdaOf_omegaA0]; right; left; rfl
  · rw [lambdaOf_omegaG05]; right; right; left; rfl
  · rw [lambdaOf_neg isPin_omegaG05, lambdaOf_omegaG05]; right; right; left; rfl
  · rw [lambdaOf_omegaA5]; right; right; right; rfl
  · rw [lambdaOf_neg isPin_omegaA5, lambdaOf_omegaA5]; right; right; right; rfl
