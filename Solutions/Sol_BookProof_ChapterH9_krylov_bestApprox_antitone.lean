import Definitions.Def_ChapterH1
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH8
-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.krylov_bestApprox_antitone
import Mathlib
import Definitions.Def_ChapterH9
import Theorems.Thm_BookProof_ChapterH9_norm_sub_starProjection_antitone
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
theorem solution (H : E →ₗ[ℂ] E) (v : E) {m n : ℕ} (hmn : m ≤ n) (u : E) :
    ‖u - (krylovSpan H v n).starProjection u‖ ≤ ‖u - (krylovSpan H v m).starProjection u‖ := norm_sub_starProjection_antitone _ _ (krylovSpan_mono hmn) u
