-- Generated from ChapterNonnegSemigroup.lean — theorem BookProof.NonnegSemigroup.norm_semigroupS_apply_le
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Mathlib
import Definitions.Def_ChapterNonnegSemigroup
open BookProof.NonnegSemigroup

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup
open Filter Topology NormedSpace
open scoped InnerProductSpace


theorem BookProof.NonnegSemigroup.norm_semigroupS_apply_le (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {t : ℝ} (ht : 0 ≤ t) (x : F) :
    ‖semigroupS hT hsv ht x‖ ≤ ‖x‖ := by sorry
