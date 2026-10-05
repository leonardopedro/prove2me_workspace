-- Generated from ChapterA4g.lean — solution of BookProof.ChapterA4g.transPhase_add
import Mathlib
import Definitions.Def_ChapterA4g
open BookProof.ChapterA4g



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (p a b : Fin 3 → ℝ) :
    transPhase p (a + b) = transPhase p a * transPhase p b := by

  unfold transPhase
  norm_num [← Complex.exp_add, mul_add, Finset.sum_add_distrib]
