-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.mem_clLp_iff
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


theorem BookProof.VonNeumannCore.mem_clLp_iff {A : D →ₗ[ℂ] F} {p : WithLp 2 (F × F)} :
    p ∈ clLp A ↔ WithLp.ofLp p ∈ clGraph A := by sorry
