-- Generated from ChapterNavierStokesFockFarisLavine.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockOp_comp
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant









open scoped ENNReal



open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}

set_option maxHeartbeats 1000000 in
theorem solution (A B : ∀ m, D m →ₗ[ℂ] D m) :
    fockOp (fun m => (A m).comp (B m)) = (fockOp A).comp (fockOp B) := by

  refine LinearMap.ext fun v => Subtype.ext (lp.ext ?_)
  funext m
  rfl
