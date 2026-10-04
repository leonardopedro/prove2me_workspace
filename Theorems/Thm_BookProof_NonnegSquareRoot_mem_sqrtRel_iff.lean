-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.mem_sqrtRel_iff
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


theorem BookProof.NonnegSquareRoot.mem_sqrtRel_iff {hT : IsNonnegSelfAdjoint T} {p : F × F} :
    p ∈ sqrtRel hT ↔ ∃ y, sqrtB hT y = p.1 ∧ sqrtC hT y = p.2 := by sorry
