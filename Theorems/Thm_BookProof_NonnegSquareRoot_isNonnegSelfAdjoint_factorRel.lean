-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.isNonnegSelfAdjoint_factorRel
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterShiftedQuadraticEsa
import Definitions.Def_ChapterVonNeumannCore
open BookProof.EsaClosure



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {a : ℝ}
variable {D : Submodule ℂ F}

theorem BookProof.NonnegSquareRoot.isNonnegSelfAdjoint_factorRel (A : D →ₗ[ℂ] F) : IsNonnegSelfAdjoint (factorRel A) where
  adj := by sorry
