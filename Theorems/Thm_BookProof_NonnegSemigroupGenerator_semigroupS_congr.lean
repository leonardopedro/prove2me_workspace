-- Generated from ChapterNonnegSemigroupGenerator.lean — theorem BookProof.NonnegSemigroupGenerator.semigroupS_congr
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


theorem BookProof.NonnegSemigroupGenerator.semigroupS_congr (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {s t : ℝ} (hs : 0 ≤ s) (ht : 0 ≤ t)
    (hst : s = t) : semigroupS hT hsv hs = semigroupS hT hsv ht := by sorry
