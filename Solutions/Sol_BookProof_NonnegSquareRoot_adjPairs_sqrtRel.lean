-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.adjPairs_sqrtRel
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtRel_le_adjPairs
import Theorems.Thm_BookProof_NonnegSquareRoot_exists_mem_sqrtRel_add
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterClosureUniqueness
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder
open BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) :
    adjPairs (sqrtRel hT) = sqrtRel hT :=
  adjPairs_eq_self_of_symmetric_of_surjective (sqrtRel_le_adjPairs hT)
      (exists_mem_sqrtRel_add hT)
