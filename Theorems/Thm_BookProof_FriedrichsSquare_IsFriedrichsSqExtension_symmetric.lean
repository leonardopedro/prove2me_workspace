-- Generated from ChapterFriedrichsSquareFactorization.lean — theorem BookProof.FriedrichsSquare.IsFriedrichsSqExtension.symmetric
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterStoneConverse
open BookProof.ClosureUniqueness
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness


theorem BookProof.FriedrichsSquare.IsFriedrichsSqExtension.symmetric {A : D →ₗ[ℂ] F} {hstab : ∀ v : D, (A v : F) ∈ D}
    {R : Submodule ℂ (F × F)} (h : IsFriedrichsSqExtension A hstab R) :
    ∀ p ∈ R, ∀ q ∈ R, (inner ℂ p.2 q.1 : ℂ) = inner ℂ p.1 q.2 := by sorry
