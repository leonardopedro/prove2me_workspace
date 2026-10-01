-- Generated from ChapterNavierStokesIkebeKato.lean — solution of BookProof.NavierStokesFlow.IkebeKato.diagMax_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_hasSum_quadForm
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato



open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
x.ofReal_re]

theorem solution (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) (x : maxDom c) :
    0 ≤ quadForm :=
  (diagMax c) x := by
    refine (diagMax_hasSum_quadForm c x).nonneg fun k => ?_
    exact mul_nonneg (hc k)
