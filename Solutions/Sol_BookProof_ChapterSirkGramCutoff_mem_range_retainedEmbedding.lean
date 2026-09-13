-- Generated from ChapterSirkGramCutoff.lean — solution of BookProof.ChapterSirkGramCutoff.mem_range_retainedEmbedding
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
theorem solution {d : ℕ} {e : Fin d → Fin m}
    (hpos : ∀ j : Fin d, 0 < lam (e j)) (j : Fin d) :
    ∃ z, retainedEmbedding w u lam e z = synthesis w (u (e j)) := by

  refine ⟨EuclideanSpace.single j ((Real.sqrt (lam (e j)) : ℂ)), ?_⟩
  have hs : Real.sqrt (lam (e j)) ≠ 0 := by
    have := hpos j; positivity
  have h1 : retainedEmbedding w u lam e (EuclideanSpace.single j
      ((Real.sqrt (lam (e j)) : ℂ))) = (Real.sqrt (lam (e j)) : ℂ) • retainedVec w u lam e j := by
    rw [retainedEmbedding, synthesis_apply, Finset.sum_eq_single j]
    · simp
    · intro l _ hl; simp [EuclideanSpace.single_apply, hl]
    · intro hj; exact absurd (Finset.mem_univ j) hj
  have hsne : ((Real.sqrt (lam (e j)) : ℝ) : ℂ) ≠ 0 := by
    simp only [ne_eq, Complex.ofReal_eq_zero]
    exact hs
  rw [h1, retainedVec, smul_smul]
  rw [mul_inv_cancel₀ hsne, one_smul]
