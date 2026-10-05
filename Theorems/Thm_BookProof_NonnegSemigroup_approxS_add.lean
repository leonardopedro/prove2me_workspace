-- Generated from ChapterNonnegSemigroup.lean — theorem BookProof.NonnegSemigroup.approxS_add
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


theorem BookProof.NonnegSemigroup.approxS_add (hT : IsNonnegSelfAdjoint T) (n : ℕ) (s t : ℝ) :
    approxS hT n (s + t) = approxS hT n s * approxS hT n t := by sorry
