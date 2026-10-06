-- Generated from ChapterMackeyImprimitivity.lean — solution of BookProof.ChapterMackeyImprimitivity.mackeyMap_injective
import Mathlib
import Definitions.Def_ChapterMackeyImprimitivity
import Theorems.Thm_BookProof_ChapterMackeyImprimitivity_mackeyMap_reconstruct
open BookProof.ChapterMackeyImprimitivity



open scoped InnerProductSpace
open Finset


variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable (S : ImprimitivitySystem G X E)
variable (S : ImprimitivitySystem G X E) (x₀ : X) (s : X → G)
variable {S x₀ s}

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective (mackeyMap S s) := by

  intro ψ φ h
  rw [← mackeyMap_reconstruct (S := S) (s := s) ψ, ← mackeyMap_reconstruct (S := S) (s := s) φ, h]
