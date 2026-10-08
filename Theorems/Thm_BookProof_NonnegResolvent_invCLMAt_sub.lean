-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.invCLMAt_sub
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
open BookProof.NonnegResolvent



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}


theorem BookProof.NonnegResolvent.invCLMAt_sub (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) (h : F) :
    invCLMAt hT ha h - invCLMAt hT hb h
      = ((b : ℂ) - (a : ℂ)) • invCLMAt hT ha (invCLMAt hT hb h) := by sorry
