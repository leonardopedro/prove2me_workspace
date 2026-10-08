-- Generated from ChapterNonnegSemigroup.lean — theorem BookProof.NonnegSemigroup.tendsto_semigroupS_zero
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

variable {T : Submodule ℂ (F × F)}

theorem BookProof.NonnegSemigroup.tendsto_semigroupS_zero (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : F) {ε : ℝ} (hε : 0 < ε) :
    ∃ δ > 0, ∀ (t : ℝ) (ht : 0 ≤ t), t < δ → ‖semigroupS hT hsv ht x - x‖ < ε := by sorry
