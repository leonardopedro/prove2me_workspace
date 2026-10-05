-- Generated from ChapterA3u.lean — solution of BookProof.ChapterA3u.invariant_sameCycle
import Mathlib
import Definitions.Def_ChapterA3u
import Theorems.Thm_BookProof_ChapterA3u_invariant_apply_zpow
open BookProof.ChapterA3u



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} {σ : Equiv.Perm (Fin N)} {a : Idx N}
    (ha : a ∘ σ = a) {x y : Fin N} (h : σ.SameCycle x y) : a x = a y := by

  obtain ⟨k, hk⟩ := h
  rw [← hk, invariant_apply_zpow ha]
