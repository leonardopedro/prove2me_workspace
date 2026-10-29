-- Generated from ChapterSoftmaxTemperatureMonotone.lean — solution of BookProof.ChapterSoftmaxTemperatureMonotone.differentiable_scoreSoftmax
import Mathlib
import Definitions.Def_ChapterSoftmaxTemperatureMonotone
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_hasDerivAt_scoreSoftmax
import Definitions.Def_ChapterSoftmaxOrder
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxFluctuation
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_partition_pos
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_hasDerivAt_partition
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_hasDerivAt_exp_mul
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_scoreSoftmax_eq_div
open BookProof.ChapterSoftmaxTemperatureMonotone



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}

variable {m : ℕ}


private theorem partition_ne_zero (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) : partition beta s ≠ 0 :=
  ne_of_gt (partition_pos beta s i)
private theorem hasDerivAt_scoreSoftmax (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    HasDerivAt (fun b : ℝ => scoreSoftmax b s j)
      (scoreSoftmax beta s j * (s j - meanScore beta s)) beta := by
  have hZ := hasDerivAt_partition beta s
  have hne := partition_ne_zero beta s j
  have hpos := partition_pos beta s j
  have hnum := hasDerivAt_exp_mul beta (s j)
  have h := hnum.div hZ hne
  refine h.congr_deriv ?_
  have hmean : meanScore beta s = (∑ l, s l * Real.exp (beta * s l)) / partition beta s := by
    rw [meanScore, Finset.sum_div]
    exact Finset.sum_congr rfl fun l _ => by
      rw [scoreSoftmax_eq_div, div_mul_eq_mul_div, mul_comm (Real.exp (beta * s l)) (s l)]
  rw [hmean, scoreSoftmax_eq_div]
  field_simp

set_option maxHeartbeats 1000000 in

theorem solution (s : Fin m → ℝ) (j : Fin m) :
    Differentiable ℝ fun b : ℝ => scoreSoftmax b s j := fun b =>
  (_root_.hasDerivAt_scoreSoftmax b s j).differentiableAt
