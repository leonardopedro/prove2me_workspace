-- Generated from ChapterDutchBook.lean — solution of BookProof.ChapterDutchBook.Coherent.empty
import Mathlib
import Definitions.Def_ChapterDutchBook
import Theorems.Thm_BookProof_ChapterDutchBook_payoff_single
open BookProof.ChapterDutchBook



open scoped BigOperators
open Finset


variable {Ω : Type*} [DecidableEq Ω]

variable {Ω : Type*} [DecidableEq Ω]

set_option maxHeartbeats 1000000 in
theorem solution {Pr : Finset Ω → ℝ} (h : Coherent Pr) : Pr (∅ : Finset Ω) = 0 := by

  by_contra hne
  apply h
  refine ⟨1, ![∅], ![if 0 < Pr ∅ then 1 else -1], ?_⟩
  intro ω
  rw [payoff_single]
  rcases lt_trichotomy (Pr ∅) 0 with hlt | heq | hgt
  · rw [if_neg (by linarith)]; simp; linarith
  · exact absurd heq hne
  · rw [if_pos hgt]; simp; linarith
