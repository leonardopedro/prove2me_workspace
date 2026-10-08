-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.positive_factor_unique
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

open ContinuousLinearMap

theorem BookProof.ClosureUniqueness.positive_factor_unique {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
    [CompleteSpace H] (B C : H →L[ℂ] H) (hB : B.IsPositive) (hC : C.IsPositive)
    (h : B ∘L B = C ∘L C) : B = C := by sorry
