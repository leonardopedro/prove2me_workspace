-- Generated from ChapterComputableScarcity.lean — theorem BookProof.ComputableScarcity.exists_not_eventually_eq_computable
import Mathlib
import Definitions.Def_ChapterComputableScarcity
open BookProof.ComputableScarcity



open Nat.Partrec

open Classical

theorem BookProof.ComputableScarcity.exists_not_eventually_eq_computable :
    ∃ f : ℕ → ℕ, ∀ g : ℕ → ℕ, Computable g → ¬ (∀ᶠ n in Filter.atTop, f n = g n) := by sorry
