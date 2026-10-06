-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.castR_mem_WTwo
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution : ∀ M ∈ SW2, castR M ∈ WTwo := by

  intro M hM
  simp only [SW2, Finset.mem_union, Finset.mem_image, Finset.mem_univ, true_and] at hM
  obtain ⟨i, rfl⟩ | ⟨i, rfl⟩ := hM <;> simp only [WTwo]
  · exact Submodule.subset_span ⟨i, rfl⟩
  · rw [show castR (-w2 i) = -castR (w2 i) by ext; simp [castR]]
    exact Submodule.neg_mem _ <| Submodule.subset_span <| Set.mem_range_self _
