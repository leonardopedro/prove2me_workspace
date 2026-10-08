-- Generated from ChapterResolventCorrespondence.lean — theorem BookProof.ResolventCorrespondence.existsUnique_isNonnegSelfAdjoint_invCLM_eq
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
open BookProof.ResolventCorrespondence



open BookProof.ClosureUniqueness BookProof.UnboundedPolar BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}


theorem BookProof.ResolventCorrespondence.existsUnique_isNonnegSelfAdjoint_invCLM_eq (h0 : 0 ≤ R) (h1 : R ≤ 1) :
    ∃! T : Submodule ℂ (F × F), ∃ hT : IsNonnegSelfAdjoint T, invCLM hT = R := by sorry
