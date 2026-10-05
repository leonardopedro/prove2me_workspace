-- Generated from ChapterEntropyTemperature.lean — solution of BookProof.ChapterEntropyTemperature.hasDerivAt_attentionEntropy
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
import Theorems.Thm_BookProof_ChapterEntropyTemperature_attentionEntropy_eq
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_hasDerivAt_logPartition
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_hasDerivAt_meanScore
open BookProof.ChapterEntropyTemperature



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (fun b : ℝ => attentionEntropy b s) (-(beta * varScore beta s)) beta := by

  have hrepr : (fun b : ℝ => attentionEntropy b s)
      = fun b : ℝ => logPartition b s - b * meanScore b s :=
    funext fun b => attentionEntropy_eq b s i
  rw [hrepr]
  have hlog := hasDerivAt_logPartition beta s i
  have hmean := hasDerivAt_meanScore beta s i
  have hprod : HasDerivAt (fun b : ℝ => b * meanScore b s)
      (1 * meanScore beta s + beta * varScore beta s) beta := by
    convert (hasDerivAt_id beta).mul hmean using 1 <;> (first | rfl | simp)
  have := hlog.sub hprod
  refine this.congr_deriv ?_
  ring
