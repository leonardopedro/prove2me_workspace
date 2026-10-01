-- Generated from ChapterNavierStokesFullEsa.lean — theorem BookProof.NavierStokesFlow.FullEsa.latticeAdvectionCLM_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (d : NSFullData F)


open scoped ENNReal

theorem BookProof.NavierStokesFlow.FullEsa.latticeAdvectionCLM_mem_finiteModes (v : Fin 15 → LinfZ) (nu : ℝ) (i : Fin 3)
    {f : L2Z} (hf : f ∈ finiteModes) : latticeAdvectionCLM v nu i f ∈ finiteModes := by sorry
