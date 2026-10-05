-- Generated from ChapterFriedrichsSquareFactorization.lean — theorem BookProof.FriedrichsSquare.factorRel_le_adjPairs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterClosureUniqueness
open BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness


theorem BookProof.FriedrichsSquare.factorRel_le_adjPairs (A : D →ₗ[ℂ] F) : factorRel A ≤ adjPairs (factorRel A) := by sorry
