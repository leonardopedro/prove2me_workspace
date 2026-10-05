-- Generated from ChapterF4.lean — solution of BookProof.ChapterF4.mgSum_decrement
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4



open scoped BigOperators Matrix

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]
variable {α κ Ω : Type*} [Fintype α] [DecidableEq α] [Fintype κ] [DecidableEq κ]
  {mΩ : MeasurableSpace Ω}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution (c : ι → ℕ) :
    (∑ a, (c a - 1)) + mgSupport c = ∑ a, c a := by

      rw [ mgSupport ];
      rw [ Finset.card_filter, ← Finset.sum_add_distrib ];
      exact Finset.sum_congr rfl fun x _ => by split_ifs <;> omega;
