import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.symmetricOn_of_diagonal
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (v : ι → E) (hv : Orthonormal ℂ v) (lam : ι → ℝ)
    {D : Submodule ℂ E} (hD : Submodule.span ℂ (Set.range v) = D)
    (T : D →ₗ[ℂ] E)
    (hT : ∀ (i : ι) (h : v i ∈ D), T ⟨v i, h⟩ = ((lam i : ℝ) : ℂ) • v i) :
    SymmetricOn D T := by

  classical
  have hvD : ∀ i, v i ∈ D := fun i => hD ▸ Submodule.subset_span ⟨i, rfl⟩
  have main : ∀ y : E, y ∈ Submodule.span ℂ (Set.range v) →
      ∀ (hy : y ∈ D) (i : ι), (inner ℂ (T ⟨v i, hvD i⟩) y : ℂ) = inner ℂ (v i) (T ⟨y, hy⟩) := by
    intro y hy0
    induction hy0 using Submodule.span_induction with
    | mem z hz =>
        obtain ⟨j, rfl⟩ := hz
        intro hy i
        rw [hT i (hvD i), hT j hy, inner_smul_left, inner_smul_right,
          orthonormal_iff_ite.mp hv i j]
        by_cases hij : i = j
        · subst hij; simp
        · simp [hij]
    | zero =>
        intro hy i
        have h0 : (⟨(0 : E), hy⟩ : D) = 0 := Subtype.ext rfl
        simp [h0]
    | add z w hz hw ihz ihw =>
        intro hy i
        have hzD : z ∈ D := hD ▸ hz
        have hwD : w ∈ D := hD ▸ hw
        have hadd : (⟨z + w, hy⟩ : D) = ⟨z, hzD⟩ + ⟨w, hwD⟩ := Subtype.ext rfl
        rw [hadd, map_add, inner_add_right, inner_add_right, ihz hzD i, ihw hwD i]
    | smul r z hz ih =>
        intro hy i
        have hzD : z ∈ D := hD ▸ hz
        have hsm : (⟨r • z, hy⟩ : D) = r • ⟨z, hzD⟩ := Subtype.ext rfl
        rw [hsm, map_smul, inner_smul_right, inner_smul_right, ih hzD i]
  have main2 : ∀ x : E, x ∈ Submodule.span ℂ (Set.range v) →
      ∀ (hx : x ∈ D) (y : E) (hy : y ∈ D),
        (inner ℂ (T ⟨x, hx⟩) y : ℂ) = inner ℂ x (T ⟨y, hy⟩) := by
    intro x hx0
    induction hx0 using Submodule.span_induction with
    | mem z hz =>
        obtain ⟨j, rfl⟩ := hz
        intro _ y hy
        exact main y (hD ▸ hy) hy j
    | zero =>
        intro hx y hy
        have h0 : (⟨(0 : E), hx⟩ : D) = 0 := Subtype.ext rfl
        simp [h0]
    | add z w hz hw ihz ihw =>
        intro hx y hy
        have hzD : z ∈ D := hD ▸ hz
        have hwD : w ∈ D := hD ▸ hw
        have hadd : (⟨z + w, hx⟩ : D) = ⟨z, hzD⟩ + ⟨w, hwD⟩ := Subtype.ext rfl
        rw [hadd, map_add, inner_add_left, inner_add_left, ihz hzD y hy, ihw hwD y hy]
    | smul r z hz ih =>
        intro hx y hy
        have hzD : z ∈ D := hD ▸ hz
        have hsm : (⟨r • z, hx⟩ : D) = r • ⟨z, hzD⟩ := Subtype.ext rfl
        rw [hsm, map_smul, inner_smul_left, inner_smul_left, ih hzD y hy]
  intro x y
  have hx : (x : E) ∈ Submodule.span ℂ (Set.range v) := hD ▸ x.2
  simpa using main2 (x : E) hx x.2 (y : E) y.2
