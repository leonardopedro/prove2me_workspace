-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.norm_smul_invCLMAt_le
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


theorem BookProof.NonnegResolvent.norm_smul_invCLMAt_le (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    ‖(a : ℂ) • invCLMAt hT ha h‖ ≤ ‖h‖ := by sorry
