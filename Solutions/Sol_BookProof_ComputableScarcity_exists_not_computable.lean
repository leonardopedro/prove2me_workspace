-- Generated from ChapterComputableScarcity.lean — solution of BookProof.ComputableScarcity.exists_not_computable
import Mathlib
import Definitions.Def_ChapterComputableScarcity
import Theorems.Thm_BookProof_ComputableScarcity_exists_differs_infinitely_often_from_all_computable
open BookProof.ComputableScarcity




open Nat.Partrec

open Classical

set_option maxHeartbeats 1000000 in
theorem solution : ∃ f : ℕ → ℕ, ¬ Computable f := by

  obtain ⟨f, hf⟩ := exists_differs_infinitely_often_from_all_computable
  refine ⟨f, fun hcomp => ?_⟩
  have := hf f hcomp
  simp at this
