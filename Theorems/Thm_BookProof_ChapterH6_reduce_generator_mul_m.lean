-- Generated from ChapterH6.lean — theorem BookProof.ChapterH6.reduce_generator_mul_m
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {m : ℕ}


noncomputable section

open Filter Topology

theorem BookProof.ChapterH6.reduce_generator_mul_m (m : ℕ) : Fintype.card (Fin m × Fin m) = m * m := by sorry
