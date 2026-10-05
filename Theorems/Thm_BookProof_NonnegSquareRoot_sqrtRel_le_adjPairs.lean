-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.sqrtRel_le_adjPairs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
open BookProof.ClosureUniqueness
open BookProof.NonnegSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open BookProof.PositiveSquareRoot
open scoped ComplexOrder


theorem BookProof.NonnegSquareRoot.sqrtRel_le_adjPairs (hT : IsNonnegSelfAdjoint T) :
    sqrtRel hT ≤ adjPairs (sqrtRel hT) := by sorry
