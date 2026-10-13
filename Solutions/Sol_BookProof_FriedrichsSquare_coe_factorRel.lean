-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.coe_factorRel
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) : (factorRel A : Set (F × F)) = factorGraph A := rfl
