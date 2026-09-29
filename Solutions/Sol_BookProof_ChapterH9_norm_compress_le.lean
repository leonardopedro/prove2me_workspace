-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.norm_compress_le
import Mathlib
import Definitions.Def_ChapterH9
import Theorems.Thm_BookProof_ChapterH9_norm_adjoint_le_one_of_isometry
open BookProof.ChapterH9



noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E) (hViso : ∀ x : F, ‖V x‖ = ‖x‖) :
    ‖compress V X‖ ≤ ‖X‖ := by

  refine ContinuousLinearMap.opNorm_le_bound _ (norm_nonneg X) fun y => ?_
  have h1 : ‖compress V X y‖ ≤ ‖adjoint V‖ * ‖X (V y)‖ := by
    simpa [compress] using (adjoint V).le_opNorm (X (V y))
  have h2 : ‖X (V y)‖ ≤ ‖X‖ * ‖y‖ := by
    calc ‖X (V y)‖ ≤ ‖X‖ * ‖V y‖ := X.le_opNorm (V y)
      _ = ‖X‖ * ‖y‖ := by rw [hViso]
  have h3 : ‖adjoint V‖ * ‖X (V y)‖ ≤ 1 * (‖X‖ * ‖y‖) := by
    refine mul_le_mul (norm_adjoint_le_one_of_isometry V hViso) h2 (norm_nonneg _) zero_le_one
  linarith [h1, h3]
