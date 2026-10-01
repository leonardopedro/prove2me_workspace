-- Generated from ChapterH1.lean — theorem BookProof.ChapterH1.phi_at_zero
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {A : Type*} [Ring A] [Algebra ℂ A]


open scoped BigOperators
open intervalIntegral


noncomputable section

theorem BookProof.ChapterH1.phi_at_zero (k : ℕ) : phi k 0 = 1 / k.factorial := by sorry
