-- Generated from ChapterLpRestrictSplit.lean — solution of BookProof.ChapterLpRestrictSplit.restrictEmbed_intertwines
import Mathlib
import Definitions.Def_ChapterLpRestrictSplit
import Theorems.Thm_BookProof_ChapterLpRestrictSplit_restrictEmbed_coeFn
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
open BookProof.ChapterLpRestrictSplit



noncomputable section

open MeasureTheory


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution {A : Set α} (hA : MeasurableSet A) {g : α → ℂ}
    (hg : MemLp g ⊤ mu) (u : Lp ℂ 2 (mu.restrict A)) :
    restrictEmbed hA (multOp g (hg.restrict A) u) = multOp g hg (restrictEmbed hA u) := by

  refine Lp.ext ?_
  filter_upwards [restrictEmbed_coeFn hA (multOp g (hg.restrict A) u),
    indicator_ae_eq_of_restrict_ae_eq (mu := mu) hA
      (multOp_coeFn (μ := mu.restrict A) g (hg.restrict A) u),
    multOp_coeFn (μ := mu) g hg (restrictEmbed hA u),
    restrictEmbed_coeFn hA u] with x h1 h2 h3 h4
  rw [h1, h2, h3, h4]
  by_cases hxA : x ∈ A <;>
    simp [Set.indicator_of_mem, Set.indicator_of_notMem, hxA]
