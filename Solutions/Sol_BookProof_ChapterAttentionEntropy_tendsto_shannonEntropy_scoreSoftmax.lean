-- Generated from ChapterAttentionEntropy.lean — solution of BookProof.ChapterAttentionEntropy.tendsto_shannonEntropy_scoreSoftmax
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
import Theorems.Thm_BookProof_ChapterSoftmaxSharpness_tendsto_scoreSoftmax_max
import Theorems.Thm_BookProof_ChapterSoftmaxSharpness_tendsto_scoreSoftmax_ne
open BookProof.ChapterAttentionEntropy



open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (j : Fin m)
    (hmax : ∀ l, l ≠ j → s l < s j) :
    Tendsto (fun b : ℝ => shannonEntropy (fun l => scoreSoftmax b s l)) atTop (𝓝 0) := by

  have hterm : ∀ l : Fin m,
      Tendsto (fun b : ℝ => scoreSoftmax b s l * Real.log (scoreSoftmax b s l))
        atTop (𝓝 0) := by
    intro l
    by_cases hl : l = j
    · subst hl
      have h := (Real.continuous_mul_log.tendsto 1).comp (tendsto_scoreSoftmax_max s l hmax)
      convert h using 1 <;> (first | rfl | simp)
    · have h := (Real.continuous_mul_log.tendsto 0).comp (tendsto_scoreSoftmax_ne s j l hmax hl)
      convert h using 1 <;> (first | rfl | simp)
  have hsum : Tendsto
      (fun b : ℝ => ∑ l, scoreSoftmax b s l * Real.log (scoreSoftmax b s l)) atTop (𝓝 0) := by
    have h := tendsto_finset_sum (Finset.univ : Finset (Fin m))
      (fun l _ => hterm l)
    simpa using h
  simpa [shannonEntropy] using hsum.neg
