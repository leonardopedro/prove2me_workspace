-- Generated from ChapterH6.lean — theorem BookProof.ChapterH6.generation_semigroup
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

theorem BookProof.ChapterH6.generation_semigroup (A : Matrix (Fin m) (Fin m) ℂ) (s t : ℂ)
    (psi0 : Fin m → ℂ) :
    generatedState A (s + t) psi0 = generatedState A s (generatedState A t psi0) := by sorry
