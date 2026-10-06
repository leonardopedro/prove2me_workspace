-- Generated from ChapterLpRestrictSplit.lean — solution of BookProof.ChapterLpRestrictSplit.isHilbertSum_splitEmbed
import Mathlib
import Definitions.Def_ChapterLpRestrictSplit
import Theorems.Thm_BookProof_ChapterLpRestrictSplit_restrictEmbed_add_restrictEmbed_compl
import Theorems.Thm_BookProof_ChapterLpRestrictSplit_orthogonalFamily_splitEmbed
open BookProof.ChapterLpRestrictSplit



noncomputable section

open MeasureTheory


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}

variable {α : Type*} [MeasurableSpace α] {mu : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution {A : Set α} (hA : MeasurableSet A) :
    IsHilbertSum ℂ (fun b : Bool => Lp ℂ 2 (mu.restrict (splitSet A b))) (splitEmbed hA) := by

  refine IsHilbertSum.mk (orthogonalFamily_splitEmbed hA) ?_
  refine le_trans ?_ (Submodule.le_topologicalClosure _)
  rintro u -
  rw [← restrictEmbed_add_restrictEmbed_compl (mu := mu) hA u]
  refine Submodule.add_mem _ ?_ ?_
  · exact le_iSup (fun b : Bool => (splitEmbed hA b).range) true ⟨restrictProj A u, rfl⟩
  · exact le_iSup (fun b : Bool => (splitEmbed hA b).range) false ⟨restrictProj Aᶜ u, rfl⟩
