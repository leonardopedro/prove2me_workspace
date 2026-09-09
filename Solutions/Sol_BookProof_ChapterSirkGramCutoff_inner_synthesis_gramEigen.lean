-- Generated from ChapterSirkGramCutoff.lean — solution of BookProof.ChapterSirkGramCutoff.inner_synthesis_gramEigen
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
open BookProof.ChapterSirkGramCutoff










noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {m : ℕ} {w : Fin m → E}
variable {u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))} {lam : Fin m → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (heig : IsGramEigen w u lam) (k l : Fin m) :
    ⟪synthesis w (u k), synthesis w (u l)⟫_ℂ = if k = l then (lam l : ℂ) else 0 := by

  have hortho : ⟪u k, u l⟫_ℂ = if k = l then (1 : ℂ) else 0 :=
    orthonormal_iff_ite.mp u.orthonormal k l
  rw [← inner_gramOp, heig l, inner_smul_right, hortho]
  by_cases h : k = l <;> simp [h]
