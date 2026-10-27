-- Generated from ChapterLpRestrictSplit.lean — solution of BookProof.ChapterLpRestrictSplit.restrictEmbed_add_restrictEmbed_compl
import Mathlib
import Definitions.Def_ChapterLpRestrictSplit
import Theorems.Thm_BookProof_ChapterLpRestrictSplit_restrictEmbed_restrictProj_coeFn
open BookProof.ChapterLpRestrictSplit



noncomputable section

open MeasureTheory


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution {A : Set α} (hA : MeasurableSet A)
    (u : Lp ℂ 2 mu) :
    restrictEmbed hA (restrictProj A u) + restrictEmbed hA.compl (restrictProj Aᶜ u) = u := by

  refine Lp.ext ?_
  filter_upwards [Lp.coeFn_add (restrictEmbed hA (restrictProj A u))
      (restrictEmbed hA.compl (restrictProj Aᶜ u)),
    restrictEmbed_restrictProj_coeFn hA u,
    restrictEmbed_restrictProj_coeFn hA.compl u] with x h1 h2 h3
  rw [h1, Pi.add_apply, h2, h3]
  by_cases hxA : x ∈ A <;>
    simp [Set.indicator_of_mem, Set.indicator_of_notMem, hxA]
