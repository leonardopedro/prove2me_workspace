-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.yosidaCLM_mem
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


theorem BookProof.NonnegResolvent.yosidaCLM_mem (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    ((a : ℂ) • invCLMAt hT ha h, yosidaCLM hT ha h) ∈ T := by sorry
