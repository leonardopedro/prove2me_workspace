-- Generated from ChapterComputableScarcity.lean — solution of BookProof.ComputableScarcity.exists_differs_infinitely_often_from_all_computable
import Mathlib
import Definitions.Def_ChapterComputableScarcity
import Theorems.Thm_BookProof_ComputableScarcity_exists_code_of_computable
import Theorems.Thm_BookProof_ComputableScarcity_exists_infinitely_often_ne
open BookProof.ComputableScarcity




open Nat.Partrec

open Classical

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ f : ℕ → ℕ, ∀ g : ℕ → ℕ, Computable g → {n | f n ≠ g n}.Infinite := by

  obtain ⟨f, hf⟩ :=
    exists_infinitely_often_ne (fun k => evalTotal ((Encodable.decode k).getD Code.zero))
  refine ⟨f, fun g hg => ?_⟩
  obtain ⟨c, hc⟩ := exists_code_of_computable hg
  have := hf (Encodable.encode c)
  simpa [hc] using this
