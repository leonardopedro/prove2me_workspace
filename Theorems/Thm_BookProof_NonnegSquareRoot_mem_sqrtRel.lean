-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.mem_sqrtRel
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


theorem BookProof.NonnegSquareRoot.mem_sqrtRel (hT : IsNonnegSelfAdjoint T) (y : F) :
    (sqrtB hT y, sqrtC hT y) ∈ sqrtRel hT := by sorry
