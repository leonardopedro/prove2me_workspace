-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.IsSymmetricDom.anticomm
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa.IsSymmetricDom



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {A B : D →ₗ[ℂ] D} (hA : IsSymmetricDom A)
    (hB : IsSymmetricDom B) : IsSymmetricDom (A.comp B + B.comp A) := by

  intro x y
  have h1 : (inner ℂ ((A (B x) : F)) (y : F) : ℂ) = inner ℂ (x : F) ((B (A y) : F)) :=
    (hA _ _).trans (hB _ _)
  have h2 : (inner ℂ ((B (A x) : F)) (y : F) : ℂ) = inner ℂ (x : F) ((A (B y) : F)) :=
    (hB _ _).trans (hA _ _)
  simp only [LinearMap.add_apply, LinearMap.comp_apply, Submodule.coe_add, inner_add_left,
    inner_add_right, h1, h2]
  ring
