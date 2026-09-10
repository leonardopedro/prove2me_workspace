-- Generated from ChapterNavierStokesFockFarisLavine.lean — theorem BookProof.NavierStokesFlow.SecondQuant.fockOp_ge_norm_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant








open scoped ENNReal



open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}

theorem BookProof.NavierStokesFlow.SecondQuant.fockOp_ge_norm_sq (N : ∀ m, D m →ₗ[ℂ] D m)
    (hb : ∀ (m : ι) (x : D m),
      ‖(x : S m)‖ ^ 2 ≤ (inner ℂ ((x : S m)) ((N m x : D m) : S m) : ℂ).re)
    (v : fockCore D) :
    ‖(v : lp S 2)‖ ^ 2
      ≤ (inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re := by sorry
