-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.inner_wgt_symm
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_wgt_apply
import Theorems.Thm_BookProof_FockWeightedSchur_support_wgt_subset
import Theorems.Thm_BookProof_FockSecondQuantization_inner_toLp_of_subset
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (u v : FockAlg) :
    (inner ℂ (toLp (wgt w u)) (toLp v) : ℂ) = inner ℂ (toLp u) (toLp (wgt w v)) := by

  classical
  have hsu : (wgt w u).support ⊆ u.support ∪ v.support :=
    (support_wgt_subset u).trans Finset.subset_union_left
  have hsv : u.support ⊆ u.support ∪ v.support := Finset.subset_union_left
  rw [inner_toLp_of_subset hsu v, inner_toLp_of_subset hsv (wgt w v)]
  refine Finset.sum_congr rfl fun α _ => ?_
  rw [wgt_apply, wgt_apply, map_mul, Complex.conj_ofReal]
  ring
