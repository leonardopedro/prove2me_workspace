-- Generated from ChapterVonNeumannCore.lean — theorem BookProof.VonNeumannCore.eq_zero_of_mem_clLp_of_orthogonal
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterA4
open BookProof.ClosureUniqueness
open BookProof.EsaClosure
open BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare


theorem BookProof.VonNeumannCore.eq_zero_of_mem_clLp_of_orthogonal (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D A) {q : WithLp 2 (F × F)} (hq : q ∈ clLp A)
    (horth : q ∈ (coreLp A)ᗮ) : q = 0 := by sorry
