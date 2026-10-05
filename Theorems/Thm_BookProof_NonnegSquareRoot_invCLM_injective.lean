-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.invCLM_injective
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
open BookProof.NonnegSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open BookProof.PositiveSquareRoot
open scoped ComplexOrder


theorem BookProof.NonnegSquareRoot.invCLM_injective (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) : Function.Injective (invCLM hT) := by sorry
