-- Generated from ChapterSirkGramWhitening.lean — theorem BookProof.ChapterSirkGramWhitening.exists_whitened_isometry_onto_span
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

rw [← hid]
    ext c
    simp

theorem BookProof.ChapterSirkGramWhitening.exists_whitened_isometry_onto_span {m : ℕ} {w : Fin m → E}
    (hw : LinearIndependent ℂ w) :
    ∃ T : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m),
      IsWhitening w T ∧
      (ContinuousLinearMap.adjoint (whitened w T)).comp (whitened w T)
        = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin m)) ∧
      LinearMap.range (whitened w T : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] E)
        = := by sorry
