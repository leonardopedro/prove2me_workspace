-- Generated from ChapterH6.lean — theorem BookProof.ChapterH6.generation_single_exponential
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6


noncomputable section

open Filter Topology

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {m : ℕ}

theorem BookProof.ChapterH6.generation_single_exponential (A : Matrix (Fin m) (Fin m) ℂ) (psi0 : Fin m → ℂ) :
    generatedState A 1 psi0 = (NormedSpace.exp ((-Complex.I) • A)).mulVec psi0 := by sorry
