-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.clLp_isClosed
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare


theorem BookProof.VonNeumannCore.clLp_isClosed (A : D →ₗ[ℂ] F) :
    IsClosed ((clLp A : Submodule ℂ (WithLp 2 (F × F))) : Set (WithLp 2 (F × F))) := by sorry
