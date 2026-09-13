-- Generated from ChapterSirkGramCutoff.lean — solution of BookProof.ChapterSirkGramCutoff.synthesis_single
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_synthesis_apply
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramCutoff










noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {m : ℕ} {w : Fin m → E}
variable {u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))} {lam : Fin m → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin m) :
    synthesis w (EuclideanSpace.single i (1 : ℂ)) = w i := by

  rw [synthesis_apply]
  rw [Finset.sum_eq_single i]
  · simp
  · intro j _ hj; simp [EuclideanSpace.single_apply, hj]
  · intro hi; exact absurd (Finset.mem_univ i) hi
