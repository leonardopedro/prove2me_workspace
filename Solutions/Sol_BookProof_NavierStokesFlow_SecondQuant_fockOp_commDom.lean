-- Generated from ChapterNavierStokesFockFarisLavine.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockOp_commDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_SecondQuant_fockOp_comp
import Theorems.Thm_BookProof_NavierStokesFlow_SecondQuant_fockOp_sub
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant









open scoped ENNReal



open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}

set_option maxHeartbeats 1000000 in
theorem solution (A B : ∀ m, D m →ₗ[ℂ] D m) :
    fockOp (fun m => commDom (A m) (B m)) = commDom (fockOp A) (fockOp B) := by

  rw [commDom, ← fockOp_comp, ← fockOp_comp, ← fockOp_sub]
  rfl
