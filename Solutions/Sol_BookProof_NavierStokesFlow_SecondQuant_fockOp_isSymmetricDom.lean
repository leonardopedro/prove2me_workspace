-- Generated from ChapterNavierStokesFockFarisLavine.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockOp_isSymmetricDom
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
theorem solution (A : ∀ m, D m →ₗ[ℂ] D m)
    (hA : ∀ m, FullEsa.IsSymmetricDom (A m)) :
    FullEsa.IsSymmetricDom (fockOp A) := by

  intro x y
  have h1 := lp.hasSum_inner (𝕜 := ℂ) ((fockOp A x : fockCore D) : lp S 2) ((y : lp S 2))
  have h2 := lp.hasSum_inner (𝕜 := ℂ) ((x : lp S 2)) ((fockOp A y : fockCore D) : lp S 2)
  have hterm : ∀ m : ι,
      (inner ℂ (((fockOp A x : fockCore D) : lp S 2) m) ((y : lp S 2) m) : ℂ)
        = inner ℂ ((x : lp S 2) m) (((fockOp A y : fockCore D) : lp S 2) m) := by
    intro m
    exact hA m ⟨(x : lp S 2) m, (x.2).2 m⟩ ⟨(y : lp S 2) m, (y.2).2 m⟩
  have h2' : HasSum
      (fun m => (inner ℂ (((fockOp A x : fockCore D) : lp S 2) m) ((y : lp S 2) m) : ℂ))
      (inner ℂ ((x : lp S 2)) ((fockOp A y : fockCore D) : lp S 2)) := by
    simpa only [hterm] using h2
  exact h1.unique h2'
