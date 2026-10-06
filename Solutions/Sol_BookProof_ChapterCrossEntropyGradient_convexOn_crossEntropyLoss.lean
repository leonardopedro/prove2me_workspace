-- Generated from ChapterCrossEntropyGradient.lean — solution of BookProof.ChapterCrossEntropyGradient.convexOn_crossEntropyLoss
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
import Theorems.Thm_BookProof_ChapterLogPartitionConvex_convexOn_logPartition
open BookProof.ChapterCrossEntropyGradient



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (y : Fin m) :
    ConvexOn ℝ Set.univ (fun b : ℝ => crossEntropyLoss b s y) := by

  have hlog : ConvexOn ℝ Set.univ (fun b : ℝ => logPartition b s) :=
    convexOn_logPartition s y
  have hlin : ConvexOn ℝ Set.univ (fun b : ℝ => -(b * s y)) := by
    refine ⟨convex_univ, fun x _ z _ a b _ _ _ => ?_⟩
    simp only [smul_eq_mul]
    exact le_of_eq (by ring)
  have heq : (fun b : ℝ => crossEntropyLoss b s y)
      = fun b : ℝ => logPartition b s + -(b * s y) := by
    funext b
    rw [crossEntropyLoss]
    ring
  rw [heq]
  exact hlog.add hlin
