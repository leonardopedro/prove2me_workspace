-- Generated from ChapterNonnegSemigroup.lean — theorem BookProof.NonnegSemigroup.approxS_add
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Mathlib
import Definitions.Def_ChapterNonnegSemigroup



open BookProof.ClosureUniqueness
open BookProof.PositiveSquareRoot
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {T : Submodule ℂ (F × F)}

theorem BookProof.NonnegSemigroup.approxS_add (hT : IsNonnegSelfAdjoint T) (n : ℕ) (s t : ℝ) :
    approxS hT n (s + t) = approxS hT n s * approxS hT n t := by sorry
