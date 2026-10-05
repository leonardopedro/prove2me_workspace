-- Generated from ChapterPositiveSquareRootUnique.lean — theorem BookProof.PositiveSquareRoot.eq_cfc_psiFun
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
open BookProof.PositiveSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder


theorem BookProof.PositiveSquareRoot.eq_cfc_psiFun (C R : H →L[ℂ] H) (hC : 0 ≤ C) (hC1 : C ≤ 1)
    (hid : R * (1 - C - C + C * C + C * C) = C * C) : C = cfc psiFun R := by sorry
