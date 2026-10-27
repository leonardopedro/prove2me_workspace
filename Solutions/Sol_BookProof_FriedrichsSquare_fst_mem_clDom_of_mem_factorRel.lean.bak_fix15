-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.fst_mem_clDom_of_mem_factorRel
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ factorRel A) :
    p.1 ∈ clDom A := by

  obtain ⟨y, hy, -⟩ := hp
  exact mem_clDom_iff.2 ⟨y, hy⟩
