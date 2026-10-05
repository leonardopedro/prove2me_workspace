-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.invCLMAt_sub_eq
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
open BookProof.NonnegResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder


theorem BookProof.NonnegResolvent.invCLMAt_sub_eq (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) :
    invCLMAt hT ha - invCLMAt hT hb = ((b : ℂ) - (a : ℂ)) • (invCLMAt hT ha * invCLMAt hT hb) := by sorry
