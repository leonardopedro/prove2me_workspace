-- Generated from ChapterNonnegSemigroupGenerator.lean — theorem BookProof.NonnegSemigroupGenerator.norm_semigroupS_sub_semigroupS_le
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterNonnegSemigroup
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
open BookProof.NonnegSemigroupGenerator

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace


theorem BookProof.NonnegSemigroupGenerator.norm_semigroupS_sub_semigroupS_le (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {s t : ℝ} (hs : 0 ≤ s) (hst : s ≤ t) (x : F) :
    ‖semigroupS hT hsv (hs.trans hst) x - semigroupS hT hsv hs x‖
      ≤ ‖semigroupS hT hsv (sub_nonneg.2 hst) x - x‖ := by sorry
