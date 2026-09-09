-- Generated from ChapterSirkGramWhitening.lean — theorem BookProof.ChapterSirkGramWhitening.exists_isometry_fin_range_eq_span
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramWhitening








noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.ChapterSirkGramWhitening.exists_isometry_fin_range_eq_span {m : ℕ} {w : Fin m → E}
    (hw : LinearIndependent ℂ w) :
    ∃ V : EuclideanSpace ℂ (Fin m) →L[ℂ] E,
      (ContinuousLinearMap.adjoint V).comp V = ContinuousLinearMap.id ℂ
        (EuclideanSpace ℂ (Fin m)) ∧
      LinearMap.range (V : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] E)
        = Submodule.span ℂ (Set.range w) := by sorry
