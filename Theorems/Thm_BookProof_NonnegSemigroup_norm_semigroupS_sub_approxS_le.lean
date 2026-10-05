-- Generated from ChapterNonnegSemigroup.lean — theorem BookProof.NonnegSemigroup.norm_semigroupS_sub_approxS_le
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


theorem BookProof.NonnegSemigroup.norm_semigroupS_sub_approxS_le (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) (m : ℕ)
    {t : ℝ} (ht : 0 ≤ t) :
    ‖semigroupS hT hsv ht h - approxS hT m t h‖ ≤ t * ‖k - yosidaAt hT m h‖ := by sorry
