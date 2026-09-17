-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.krylov_bestApprox_antitone
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

theorem BookProof.ChapterH9.krylov_bestApprox_antitone (H : E →ₗ[ℂ] E) (v : E) {m n : ℕ} (hmn : m ≤ n) (u : E) :
    ‖u - (krylovSpan H v n).starProjection u‖ ≤ ‖u - (krylovSpan H v m).starProjection u‖ := by sorry
