-- Generated from ChapterH7.lean — theorem BookProof.ChapterH7.generation_preserves_l2
import Definitions.Def_ChapterH4
import Mathlib
import Definitions.Def_ChapterH7
import Definitions.Def_ChapterH6
open BookProof.ChapterH6
open BookProof.ChapterH7

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {m : ℕ}


noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

theorem BookProof.ChapterH7.generation_preserves_l2 (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (hA : A.IsHermitian) (psi0 : Fin m → ℂ) :
    ∑ i, Complex.normSq (generatedState A (t : ℂ) psi0 i) = ∑ i, Complex.normSq (psi0 i) := by sorry
