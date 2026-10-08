-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.yosidaCLM_mono
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


theorem BookProof.NonnegResolvent.yosidaCLM_mono (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) (hab : a ≤ b) :
    yosidaCLM hT ha ≤ yosidaCLM hT hb := by sorry
