-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.mem_coreLp_iff
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
open BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare


theorem BookProof.VonNeumannCore.mem_coreLp_iff {A : D →ₗ[ℂ] F} {p : WithLp 2 (F × F)} :
    p ∈ coreLp A ↔ WithLp.ofLp p ∈ coreGraph A := by sorry
