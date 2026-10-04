-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.sqrtC_sqrtC_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterA4
open BookProof.NonnegSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open scoped ComplexOrder


theorem BookProof.NonnegSquareRoot.sqrtC_sqrtC_apply (hT : IsNonnegSelfAdjoint T) (y : F) :
    sqrtC hT (sqrtC hT y) = y - invCLM hT y := by sorry
