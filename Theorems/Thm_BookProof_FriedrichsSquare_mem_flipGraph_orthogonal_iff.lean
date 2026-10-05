-- Generated from ChapterFriedrichsSquareFactorization.lean — theorem BookProof.FriedrichsSquare.mem_flipGraph_orthogonal_iff
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.ClosureUniqueness
open BookProof.EsaClosure
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness


theorem BookProof.FriedrichsSquare.mem_flipGraph_orthogonal_iff {A : D →ₗ[ℂ] F} {q : WithLp 2 (F × F)} :
    q ∈ (flipGraph A)ᗮ ↔ WithLp.ofLp q ∈ adjGraph A := by sorry
