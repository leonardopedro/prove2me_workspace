-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.existsUnique_smul_add_mem
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterA4
open BookProof.NonnegSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}
variable {a : ℝ}



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open scoped ComplexOrder


theorem BookProof.NonnegSquareRoot.existsUnique_smul_add_mem (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    ∃! x : F, (x, h - (a : ℂ) • x) ∈ T := by sorry
