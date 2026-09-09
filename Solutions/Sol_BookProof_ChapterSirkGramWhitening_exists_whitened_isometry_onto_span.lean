-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.exists_whitened_isometry_onto_span
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_whitened_adjoint_comp_self
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_range_whitened
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_exists_isWhitening
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} {w : Fin m → E}
    (hw : LinearIndependent ℂ w) :
    ∃ T : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m),
      IsWhitening w T ∧
      (ContinuousLinearMap.adjoint (whitened w T)).comp (whitened w T)
        = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin m)) ∧
      LinearMap.range (whitened w T : EuclideanSpace ℂ (Fin m) →ₗ[ℂ] E)
        = Submodule.span ℂ (Set.range w) := by

  obtain ⟨T, hbij, hT⟩ := exists_isWhitening hw
  exact ⟨T, hT, whitened_adjoint_comp_self w hT, range_whitened w hbij.2⟩
