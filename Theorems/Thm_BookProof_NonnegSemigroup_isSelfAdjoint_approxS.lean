-- Generated from ChapterNonnegSemigroup.lean — theorem BookProof.NonnegSemigroup.isSelfAdjoint_approxS
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

theorem BookProof.NonnegSemigroup.isSelfAdjoint_approxS (hT : IsNonnegSelfAdjoint T) (n : ℕ) (t : ℝ) :
    IsSelfAdjoint (approxS hT n t) := by sorry
