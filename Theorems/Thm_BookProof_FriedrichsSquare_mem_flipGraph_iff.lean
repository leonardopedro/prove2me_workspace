-- Generated from ChapterFriedrichsSquareFactorization.lean — theorem BookProof.FriedrichsSquare.mem_flipGraph_iff
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness


theorem BookProof.FriedrichsSquare.mem_flipGraph_iff {A : D →ₗ[ℂ] F} {p : WithLp 2 (F × F)} :
    p ∈ flipGraph A ↔ ((WithLp.ofLp p).2, -(WithLp.ofLp p).1) ∈ clGraph A := by sorry
