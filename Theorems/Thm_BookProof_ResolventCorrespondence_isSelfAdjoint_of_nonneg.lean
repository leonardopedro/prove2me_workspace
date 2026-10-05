-- Generated from ChapterResolventCorrespondence.lean — theorem BookProof.ResolventCorrespondence.isSelfAdjoint_of_nonneg
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
open BookProof.ResolventCorrespondence

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder


theorem BookProof.ResolventCorrespondence.isSelfAdjoint_of_nonneg {A : F →L[ℂ] F} (hA : 0 ≤ A) : IsSelfAdjoint A := by sorry
