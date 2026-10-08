-- Generated from ChapterNonnegSemigroupGenerator.lean — theorem BookProof.NonnegSemigroupGenerator.yosidaCLM_ge
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterNonnegSemigroup
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
open BookProof.NonnegSemigroupGenerator



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {T : Submodule ℂ (F × F)}

theorem BookProof.NonnegSemigroupGenerator.yosidaCLM_ge (hT : IsNonnegSelfAdjoint T) {a lam : ℝ} (ha : 0 < a) (hlam : 0 ≤ lam)
    (hgap : ∀ h k : F, (h, k) ∈ T → lam * ‖h‖ ^ 2 ≤ (inner ℂ h k : ℂ).re) (h : F) :
    (a * lam / (a + lam)) * ‖h‖ ^ 2 ≤ (inner ℂ (yosidaCLM hT ha h) h : ℂ).re := by sorry
