-- Generated from ChapterResolventCorrespondence.lean — theorem BookProof.ResolventCorrespondence.relOfCLM_invCLM
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


theorem BookProof.ResolventCorrespondence.relOfCLM_invCLM (hT : IsNonnegSelfAdjoint T) : relOfCLM (invCLM hT) = T := by sorry
