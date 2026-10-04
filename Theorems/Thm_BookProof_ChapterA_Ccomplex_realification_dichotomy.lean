-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.Ccomplex_realification_dichotomy
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.Ccomplex_realification_dichotomy [Nontrivial W]
    {M : System ℂ V} {N : System ℂ W}
    (hSchurN : IsSchurFull N) (hNo : NoAntilinearCommutant N)
    {β : V ≃ₗᵢ[ℝ] W} (hβ : IsRealSystemIso M N β) :
    CLinear β ∨ CAntilinear β := by sorry
