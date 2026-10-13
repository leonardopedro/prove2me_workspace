-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.mem_clLp_iff
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterEsaClosureCore
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A : D →ₗ[ℂ] F} {p : WithLp 2 (F × F)} :
    p ∈ clLp A ↔ WithLp.ofLp p ∈ clGraph A := Iff.rfl
