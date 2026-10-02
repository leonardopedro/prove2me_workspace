-- Generated from ChapterH4.lean — solution of BookProof.ChapterH4.compress_transfer
import Mathlib
import Definitions.Def_ChapterH4
import Theorems.Thm_BookProof_ChapterH4_compress_pow
open BookProof.ChapterH4



open scoped BigOperators


noncomputable section

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F)
    (hinv : ∀ x : F, ∃ y : F, X (V x) = V y) (n : ℕ)
    (v : E) (hv : V (V.adjoint v) = v) :
    (X ^ n) v = V ((compress V X ^ n) (V.adjoint v)) := by

  calc (X ^ n) v = ((X ^ n).comp V) (V.adjoint v) := by
        rw [ContinuousLinearMap.comp_apply, hv]
    _ = (V.comp ((compress V X) ^ n)) (V.adjoint v) := by
        rw [compress_pow V X hVV hinv n]
    _ = V ((compress V X ^ n) (V.adjoint v)) := rfl
