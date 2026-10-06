-- Generated from ChapterComputableScarcity.lean — theorem BookProof.ComputableScarcity.exists_infinitely_often_ne
import Mathlib
import Definitions.Def_ChapterComputableScarcity
open BookProof.ComputableScarcity



open Nat.Partrec

open Classical

theorem BookProof.ComputableScarcity.exists_infinitely_often_ne (e : ℕ → (ℕ → ℕ)) :
    ∃ f : ℕ → ℕ, ∀ k, {n | f n ≠ e k n}.Infinite := by sorry
