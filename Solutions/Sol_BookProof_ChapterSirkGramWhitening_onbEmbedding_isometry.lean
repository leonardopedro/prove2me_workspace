-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.onbEmbedding_isometry
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_adjoint_comp_self_of_inner
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_onbEmbedding_apply
import Definitions.Def_ChapterSirkWhitening
import Definitions.Def_ChapterH4
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} (S : Submodule ℂ E) [CompleteSpace S]
    (b : OrthonormalBasis (Fin d) ℂ S) :
    (ContinuousLinearMap.adjoint (onbEmbedding S b)).comp (onbEmbedding S b)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin d)) := by

  refine adjoint_comp_self_of_inner _ fun c e => ?_
  have hcoe : ⟪(b.repr.symm c : E), (b.repr.symm e : E)⟫_ℂ
      = ⟪b.repr.symm c, b.repr.symm e⟫_ℂ := rfl
  rw [onbEmbedding_apply, onbEmbedding_apply, hcoe, LinearIsometryEquiv.inner_map_map]
