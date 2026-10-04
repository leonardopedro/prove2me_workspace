-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.adjPairs_sqrtRel
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterA4
open BookProof.ClosureUniqueness
open BookProof.NonnegSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open scoped ComplexOrder


theorem BookProof.NonnegSquareRoot.adjPairs_sqrtRel (hT : IsNonnegSelfAdjoint T) :
    adjPairs (sqrtRel hT) = sqrtRel hT := by sorry
