-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.norm_yosidaCLM_le_of_mem
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


theorem BookProof.NonnegResolvent.norm_yosidaCLM_le_of_mem (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) {h k : F}
    (hk : (h, k) ∈ T) : ‖yosidaCLM hT ha h‖ ≤ ‖k‖ := by sorry
