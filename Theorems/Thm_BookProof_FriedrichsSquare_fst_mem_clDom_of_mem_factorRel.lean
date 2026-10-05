-- Generated from ChapterFriedrichsSquareFactorization.lean — theorem BookProof.FriedrichsSquare.fst_mem_clDom_of_mem_factorRel
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



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness


theorem BookProof.FriedrichsSquare.fst_mem_clDom_of_mem_factorRel {A : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ factorRel A) :
    p.1 ∈ clDom A := by sorry
