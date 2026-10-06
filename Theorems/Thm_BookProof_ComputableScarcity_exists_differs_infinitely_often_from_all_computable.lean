-- Generated from ChapterComputableScarcity.lean — theorem BookProof.ComputableScarcity.exists_differs_infinitely_often_from_all_computable
import Mathlib
import Definitions.Def_ChapterComputableScarcity
open BookProof.ComputableScarcity



open Nat.Partrec

open Classical

theorem BookProof.ComputableScarcity.exists_differs_infinitely_often_from_all_computable :
    ∃ f : ℕ → ℕ, ∀ g : ℕ → ℕ, Computable g → {n | f n ≠ g n}.Infinite := by sorry
