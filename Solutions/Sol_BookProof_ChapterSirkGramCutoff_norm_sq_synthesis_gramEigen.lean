-- Generated from ChapterSirkGramCutoff.lean — solution of BookProof.ChapterSirkGramCutoff.norm_sq_synthesis_gramEigen
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
import Theorems.Thm_BookProof_ChapterSirkGramCutoff_inner_synthesis_gramEigen
open BookProof.ChapterSirkGramCutoff










noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {m : ℕ} {w : Fin m → E}
variable {u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))} {lam : Fin m → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (heig : IsGramEigen w u lam) (k : Fin m) :
    ‖synthesis w (u k)‖ ^ 2 = lam k := by

  have h := inner_synthesis_gramEigen heig k k
  rw [if_pos rfl, inner_self_eq_norm_sq_to_K] at h
  have h2 : ((‖synthesis w (u k)‖ ^ 2 : ℝ) : ℂ) = ((lam k : ℝ) : ℂ) := by
    push_cast
    exact h
  exact Complex.ofReal_inj.mp h2
