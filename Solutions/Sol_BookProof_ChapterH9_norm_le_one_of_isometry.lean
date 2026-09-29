-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.norm_le_one_of_isometry
import Mathlib
import Definitions.Def_ChapterH9
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
omit [CompleteSpace E] [CompleteSpace F] in
theorem solution (V : F →L[ℂ] E) (hViso : ∀ x : F, ‖V x‖ = ‖x‖) :
    ‖V‖ ≤ 1 := ContinuousLinearMap.opNorm_le_bound _ zero_le_one fun x => by rw [hViso, one_mul]
