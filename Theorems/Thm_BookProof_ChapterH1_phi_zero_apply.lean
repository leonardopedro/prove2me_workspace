-- Generated from ChapterH1.lean — theorem BookProof.ChapterH1.phi_zero_apply
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {A : Type*} [Ring A] [Algebra ℂ A]


open scoped BigOperators
open intervalIntegral


noncomputable section

theorem BookProof.ChapterH1.phi_zero_apply (z : ℂ) : phi 0 z = Complex.exp z := by sorry
