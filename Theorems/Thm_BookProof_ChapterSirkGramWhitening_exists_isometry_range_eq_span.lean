-- Generated from ChapterSirkGramWhitening.lean — theorem BookProof.ChapterSirkGramWhitening.exists_isometry_range_eq_span
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramWhitening








noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.ChapterSirkGramWhitening.exists_isometry_range_eq_span {m : ℕ} (w : Fin m → E) :
    ∃ (d : ℕ) (V : EuclideanSpace ℂ (Fin d) →L[ℂ] E),
      d = Module.finrank ℂ (Submodule.span ℂ (Set.range w)) ∧
      (ContinuousLinearMap.adjoint V).comp V = ContinuousLinearMap.id ℂ
        (EuclideanSpace ℂ (Fin d)) ∧
      LinearMap.range (V : EuclideanSpace ℂ (Fin d) →ₗ[ℂ] E)
        = Submodule.span ℂ (Set.range w) := by sorry
