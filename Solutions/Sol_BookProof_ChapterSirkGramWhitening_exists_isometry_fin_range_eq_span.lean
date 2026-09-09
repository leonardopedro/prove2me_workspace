-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.exists_isometry_fin_range_eq_span
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_onbEmbedding_isometry
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_range_onbEmbedding
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} {w : Fin m → E}
    (hw : LinearIndependent ℂ w) :
    ∃ V : EuclideanSpace ℂ (Fin m) →L[ℂ] E,
      (ContinuousLinearMap.adjoint V).comp V = ContinuousLinearMap.id ℂ
        (EuclideanSpace ℂ (Fin m)) ∧
      LinearMap.range (V : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] E)
        = Submodule.span ℂ (Set.range w) := by

  set S := Submodule.span ℂ (Set.range w) with hS
  haveI : FiniteDimensional ℂ S :=
    FiniteDimensional.span_of_finite ℂ (Set.finite_range w)
  have hd : Module.finrank ℂ S = m := by
    rw [hS, finrank_span_eq_card hw, Fintype.card_fin]
  let b : OrthonormalBasis (Fin m) ℂ S := (stdOrthonormalBasis ℂ S).reindex (finCongr hd)
  exact ⟨onbEmbedding S b, onbEmbedding_isometry S b, range_onbEmbedding S b⟩
