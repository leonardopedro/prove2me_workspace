-- Generated from ChapterSirkGramCutoff.lean — solution of BookProof.ChapterSirkGramCutoff.synthesis_eq_sum_gramEigen
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
theorem solution (c : EuclideanSpace ℂ (Fin m)) :
    synthesis w c = ∑ k, ⟪u k, c⟫_ℂ • synthesis w (u k) := by

  conv_lhs => rw [← u.sum_repr' c]
  rw [map_sum]
  exact Finset.sum_congr rfl fun k _ => map_smul _ _ _
