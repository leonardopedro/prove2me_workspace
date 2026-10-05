-- Generated from ChapterCoherentFidelity.lean — solution of BookProof.ChapterCoherentFidelity.fidelityC_pos
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
import Theorems.Thm_BookProof_ChapterCoherentFidelity_fidelityC_eq_exp_neg_dist_sq
open BookProof.ChapterCoherentFidelity



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℂ (Fin n)) : 0 < fidelityC q k := by

  rw [fidelityC_eq_exp_neg_dist_sq]; exact Real.exp_pos _
