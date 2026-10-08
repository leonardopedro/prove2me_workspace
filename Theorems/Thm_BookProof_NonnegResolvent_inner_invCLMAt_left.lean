-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.inner_invCLMAt_left
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


theorem BookProof.NonnegResolvent.inner_invCLMAt_left (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h k : F) :
    (inner ℂ (invCLMAt hT ha h) k : ℂ) = inner ℂ h (invCLMAt hT ha k) := by sorry
