-- Generated from ChapterDutchBook.lean — solution of BookProof.ChapterDutchBook.coherent_exists_prob
import Mathlib
import Definitions.Def_ChapterDutchBook
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_nonneg
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_univ
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_represents_singleton
open BookProof.ChapterDutchBook



open scoped BigOperators
open Finset


variable {Ω : Type*} [DecidableEq Ω]

variable {Ω : Type*} [DecidableEq Ω]

set_option maxHeartbeats 1000000 in
theorem solution [Fintype Ω] {Pr : Finset Ω → ℝ} (h : Coherent Pr) :
    ∃ p : Ω → ℝ, IsProb p ∧ Represents Pr p := by

  refine ⟨fun ω => Pr {ω}, ⟨fun ω => h.nonneg _, ?_⟩, fun A => h.represents_singleton A⟩
  have h2 := h.represents_singleton (Finset.univ : Finset Ω)
  have h1 := h.univ
  rw [h2] at h1
  simpa using h1
