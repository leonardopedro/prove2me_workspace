-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.sqrtB_sqrtB_apply
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtB_mul_sqrtB
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (y : F) :
    sqrtB hT (sqrtB hT y) = invCLM hT y := by

  have h : (sqrtB hT * sqrtB hT) y = invCLM hT y := by rw [sqrtB_mul_sqrtB]
  exact h
