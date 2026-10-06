-- Generated from ChapterA1.lean — theorem BookProof.ChapterA.conjugation_smul_I_of_neg
import Mathlib
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

theorem BookProof.ChapterA.conjugation_smul_I_of_neg (θ : AntiUnitary V) {y : V} (hy : θ y = -y) :
    θ (Complex.I • y) = Complex.I • y := by sorry
