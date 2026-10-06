-- Generated from ChapterComputableScarcity.lean — solution of BookProof.ComputableScarcity.countable_computable
import Mathlib
import Definitions.Def_ChapterComputableScarcity
import Theorems.Thm_BookProof_ComputableScarcity_exists_code_of_computable
open BookProof.ComputableScarcity




open Nat.Partrec

open Classical

set_option maxHeartbeats 1000000 in
theorem solution : {f : ℕ → ℕ | Computable f}.Countable := by

  have hsub : {f : ℕ → ℕ | Computable f} ⊆ Set.range evalTotal := by
    intro f hf
    obtain ⟨c, hc⟩ := exists_code_of_computable hf
    exact ⟨c, hc⟩
  exact Set.Countable.mono hsub (Set.countable_range _)
