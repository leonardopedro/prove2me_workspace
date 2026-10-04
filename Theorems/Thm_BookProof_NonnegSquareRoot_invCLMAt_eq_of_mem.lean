-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.invCLMAt_eq_of_mem
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


theorem BookProof.NonnegSquareRoot.invCLMAt_eq_of_mem (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) {x h : F}
    (hx : (x, h - (a : ℂ) • x) ∈ T) : invCLMAt hT ha h = x := by sorry
