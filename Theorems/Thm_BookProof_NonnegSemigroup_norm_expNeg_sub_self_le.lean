-- Generated from ChapterNonnegSemigroup.lean — theorem BookProof.NonnegSemigroup.norm_expNeg_sub_self_le
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Mathlib
import Definitions.Def_ChapterNonnegSemigroup
open BookProof.NonnegSemigroup



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


theorem BookProof.NonnegSemigroup.norm_expNeg_sub_self_le (A : F →L[ℂ] F) (hA : 0 ≤ A) {t : ℝ} (ht : 0 ≤ t) (x : F) :
    ‖expNeg A t x - x‖ ≤ t * ‖A x‖ := by sorry
