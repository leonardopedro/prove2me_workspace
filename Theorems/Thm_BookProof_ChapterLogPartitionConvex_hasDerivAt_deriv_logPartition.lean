-- Generated from ChapterLogPartitionConvex.lean — theorem BookProof.ChapterLogPartitionConvex.hasDerivAt_deriv_logPartition
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterLogPartitionConvex
import Definitions.Def_ChapterSoftmaxFluctuation
open BookProof.ChapterLogPartitionConvex


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}


theorem BookProof.ChapterLogPartitionConvex.hasDerivAt_deriv_logPartition (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (deriv fun b : ℝ => logPartition b s) (varScore beta s) beta := by sorry
