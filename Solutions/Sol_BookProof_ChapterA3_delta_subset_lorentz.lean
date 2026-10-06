-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.delta_subset_lorentz
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaA0
import Theorems.Thm_BookProof_ChapterA3_lambdaOf_omegaA0
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaA5
import Theorems.Thm_BookProof_ChapterA3_lambdaOf_omegaA5
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaG05
import Theorems.Thm_BookProof_ChapterA3_lambdaOf_omegaG05
import Theorems.Thm_BookProof_ChapterA3_lambda_mem_lorentz
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : LorentzDelta ⊆ LorentzO := by

  intro Λ hΛ
  simp only [LorentzDelta, Set.mem_insert_iff, Set.mem_singleton_iff] at hΛ
  rcases hΛ with h | h | h | h <;> subst h
  · simp [LorentzO]
  · have := lambda_mem_lorentz omegaA0 isPin_omegaA0; rwa [lambdaOf_omegaA0] at this
  · have := lambda_mem_lorentz omegaG05 isPin_omegaG05; rwa [lambdaOf_omegaG05] at this
  · have := lambda_mem_lorentz omegaA5 isPin_omegaA5; rwa [lambdaOf_omegaA5] at this
