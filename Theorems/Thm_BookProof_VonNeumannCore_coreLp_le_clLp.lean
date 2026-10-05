-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.coreLp_le_clLp
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


theorem BookProof.VonNeumannCore.coreLp_le_clLp (A : D →ₗ[ℂ] F) : coreLp A ≤ clLp A := by sorry
