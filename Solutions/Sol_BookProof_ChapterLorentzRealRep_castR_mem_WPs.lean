-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.castR_mem_WPs
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution : ∀ M ∈ SBPs, castR M ∈ WPs := by

  intro M hM
  unfold SBPs at hM
  simp only [Finset.mem_union, Finset.mem_image, Finset.mem_univ, true_and] at hM
  rcases hM with ⟨i, rfl⟩ | ⟨i, rfl⟩;
  · exact Submodule.subset_span ⟨ i, rfl ⟩;
  · rw [show castR (-bPs i) = -castR (bPs i) by ext; simp [castR]]
    exact Submodule.neg_mem _ (Submodule.subset_span (Set.mem_range_self i))
