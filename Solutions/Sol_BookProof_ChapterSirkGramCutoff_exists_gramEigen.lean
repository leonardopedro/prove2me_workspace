-- Generated from ChapterSirkGramCutoff.lean — solution of BookProof.ChapterSirkGramCutoff.exists_gramEigen
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_gramOp_isSelfAdjoint
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramCutoff










noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (w : Fin m → E) :
    ∃ (u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (lam : Fin m → ℝ),
      IsGramEigen w u lam := by

  have hsymm : ((gramOp w : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m)) :
      EuclideanSpace ℂ (Fin m) →ₗ[ℂ] EuclideanSpace ℂ (Fin m)).IsSymmetric := by
    intro x y
    have hsa := gramOp_isSelfAdjoint w
    rw [IsSelfAdjoint, ContinuousLinearMap.star_eq_adjoint] at hsa
    change ⟪gramOp w x, y⟫_ℂ = ⟪x, gramOp w y⟫_ℂ
    conv_lhs => rw [← hsa]
    rw [ContinuousLinearMap.adjoint_inner_left]
  have hfr : Module.finrank ℂ (EuclideanSpace ℂ (Fin m)) = m := by simp
  exact ⟨hsymm.eigenvectorBasis hfr, fun k => hsymm.eigenvalues hfr k,
    fun k => hsymm.apply_eigenvectorBasis hfr k⟩
