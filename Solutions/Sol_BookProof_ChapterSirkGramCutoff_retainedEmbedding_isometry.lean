-- Generated from ChapterSirkGramCutoff.lean — solution of BookProof.ChapterSirkGramCutoff.retainedEmbedding_isometry
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
import Theorems.Thm_BookProof_ChapterSirkGramCutoff_retainedVec_orthonormal
import Theorems.Thm_BookProof_ChapterSirkGramCutoff_synthesis_isometry_of_orthonormal
open BookProof.ChapterSirkGramCutoff










noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {m : ℕ} {w : Fin m → E}
variable {u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))} {lam : Fin m → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (heig : IsGramEigen w u lam) {d : ℕ} {e : Fin d → Fin m}
    (he : Function.Injective e) (hpos : ∀ j, 0 < lam (e j)) :
    (adjoint (retainedEmbedding w u lam e)).comp (retainedEmbedding w u lam e)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin d)) := synthesis_isometry_of_orthonormal (retainedVec_orthonormal heig he hpos)
