-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.norm_invCLMAt_le
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


theorem BookProof.NonnegSquareRoot.norm_invCLMAt_le (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    ‖invCLMAt hT ha h‖ ≤ a⁻¹ * ‖h‖ := by sorry
