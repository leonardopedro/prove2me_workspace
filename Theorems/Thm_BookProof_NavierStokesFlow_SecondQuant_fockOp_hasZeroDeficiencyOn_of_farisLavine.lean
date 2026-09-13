-- Generated from ChapterNavierStokesFockFarisLavine.lean — theorem BookProof.NavierStokesFlow.SecondQuant.fockOp_hasZeroDeficiencyOn_of_farisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant
open scoped ENNReal
open BookProof.NavierStokesFlow.FarisLavineLift
open BookProof.NavierStokesFlow.FullEsa
open BookProof.NavierStokesFlow.FarisLavineLift
variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}

theorem BookProof.NavierStokesFlow.SecondQuant.fockOp_hasZeroDeficiencyOn_of_farisLavine
    (H N : ∀ m, D m →ₗ[ℂ] D m) (c₁ c₂ : ℝ) (hc₁ : 0 ≤ c₁) (hc₂ : 0 ≤ c₂)
    (farisLavine : ∀ (D' : Submodule ℂ (lp S 2)) (H' N' : D' →ₗ[ℂ] D') (a b : ℝ),
      Dense (D' : Set (lp S 2)) →
      (∀ x y : D', (inner ℂ (H' x : lp S 2) (y : lp S 2) : ℂ)
        = inner ℂ (x : lp S 2) (H' y : lp S 2)) →
      (∀ v : D', ‖(H' v : lp S 2)‖ ≤ a * ‖(N' v : lp S 2)‖) →
      (∀ v : D', ‖(inner ℂ (v : lp S 2)
          ((H' (N' v) : lp S 2) - (N' (H' v) : lp S 2)) : ℂ)‖
        ≤ b * ‖(inner ℂ (v : lp S 2) (N' v : lp S 2) : ℂ)‖) →
      HasZeroDeficiencyOn D' H')
    (hdense : ∀ m, Dense ((D m : Submodule ℂ (S m)) : Set (S m)))
    (hsym : ∀ m, FullEsa.IsSymmetricDom (H m))
    (hbound : ∀ (m : ι) (x : D m), ‖((H m x : D m) : S m)‖ ≤ c₁ * ‖((N m x : D m) : S m)‖)
    (hcomm : ∀ (m : ι) (x : D m),
      ‖(inner ℂ ((x : S m)) ((commDom (H m) (N m) x : D m) : S m) : ℂ)‖
        ≤ c₂ * (inner ℂ ((x : S m)) ((N m x : D m) : S m) : ℂ).re) :
    HasZeroDeficiencyOn (fockCore D) (fockOp H) := by sorry
