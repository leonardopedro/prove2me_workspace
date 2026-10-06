-- Generated from ChapterNavierStokesBilinearEsa.lean — solution of BookProof.NavierStokesFlow.BilinearEsa.hasSum_inner_blocks
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.BilinearEsa



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (x y : L2I (ℕ × J)) :
    HasSum (fun j : J => (inner ℂ (blockVec x j) (blockVec y j) : ℂ)) (inner ℂ x y) := by

  have h1 : HasSum (fun p : ℕ × J =>
      (inner ℂ ((x : ℕ × J → ℂ) p) ((y : ℕ × J → ℂ) p) : ℂ)) (inner ℂ x y) :=
    lp.hasSum_inner x y
  have h2 : HasSum (fun q : J × ℕ =>
      (inner ℂ ((x : ℕ × J → ℂ) (q.2, q.1)) ((y : ℕ × J → ℂ) (q.2, q.1)) : ℂ))
      (inner ℂ x y) := by
    have hiff := (Equiv.prodComm J ℕ).hasSum_iff
      (f := fun p : ℕ × J => (inner ℂ ((x : ℕ × J → ℂ) p) ((y : ℕ × J → ℂ) p) : ℂ))
      (a := (inner ℂ x y : ℂ))
    exact hiff.2 h1
  refine h2.prod_fiberwise ?_
  intro j
  exact lp.hasSum_inner (blockVec x j) (blockVec y j)
