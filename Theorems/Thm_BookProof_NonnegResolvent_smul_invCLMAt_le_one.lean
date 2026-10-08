-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.smul_invCLMAt_le_one
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


theorem BookProof.NonnegResolvent.smul_invCLMAt_le_one (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) :
    (a : ℂ) • invCLMAt hT ha ≤ 1 := by sorry
