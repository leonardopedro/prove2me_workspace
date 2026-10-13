-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.isSelfAdjoint_invCLM
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_inner_invCLM_left
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) : IsSelfAdjoint (invCLM hT) := by

  rw [ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric]
  intro x y
  exact inner_invCLM_left hT x y
