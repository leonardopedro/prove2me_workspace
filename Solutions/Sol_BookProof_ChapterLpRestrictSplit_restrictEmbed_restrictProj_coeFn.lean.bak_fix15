-- Generated from ChapterLpRestrictSplit.lean — solution of BookProof.ChapterLpRestrictSplit.restrictEmbed_restrictProj_coeFn
import Mathlib
import Definitions.Def_ChapterLpRestrictSplit
import Theorems.Thm_BookProof_ChapterLpRestrictSplit_restrictEmbed_coeFn
open BookProof.ChapterLpRestrictSplit



noncomputable section

open MeasureTheory


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution {A : Set α} (hA : MeasurableSet A) (u : Lp ℂ 2 mu) :
    (restrictEmbed hA (restrictProj A u) : α → ℂ) =ᵐ[mu] A.indicator (u : α → ℂ) := by

  refine (restrictEmbed_coeFn hA _).trans ?_
  exact indicator_ae_eq_of_restrict_ae_eq hA (((Lp.memLp u).restrict A).coeFn_toLp)
