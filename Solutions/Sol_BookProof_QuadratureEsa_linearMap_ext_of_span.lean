-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.linearMap_ext_of_span
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {E M ι : Type*} [AddCommGroup E] [Module ℂ E]
    [AddCommGroup M] [Module ℂ M] (v : ι → E) {D : Submodule ℂ E}
    (hD : Submodule.span ℂ (Set.range v) = D) (hvD : ∀ i, v i ∈ D)
    (F G : D →ₗ[ℂ] M) (h : ∀ i, F ⟨v i, hvD i⟩ = G ⟨v i, hvD i⟩) : F = G := by

  have main : ∀ y : E, y ∈ Submodule.span ℂ (Set.range v) → ∀ hy : y ∈ D,
      F ⟨y, hy⟩ = G ⟨y, hy⟩ := by
    intro y hy0
    induction hy0 using Submodule.span_induction with
    | mem z hz =>
        obtain ⟨j, rfl⟩ := hz
        intro _
        exact h j
    | zero =>
        intro hy
        have h0 : (⟨(0 : E), hy⟩ : D) = 0 := Subtype.ext rfl
        rw [h0, map_zero, map_zero]
    | add z w hz hw ihz ihw =>
        intro hy
        have hzD : z ∈ D := hD ▸ hz
        have hwD : w ∈ D := hD ▸ hw
        have hadd : (⟨z + w, hy⟩ : D) = ⟨z, hzD⟩ + ⟨w, hwD⟩ := Subtype.ext rfl
        rw [hadd, map_add, map_add, ihz hzD, ihw hwD]
    | smul r z hz ih =>
        intro hy
        have hzD : z ∈ D := hD ▸ hz
        have hsm : (⟨r • z, hy⟩ : D) = r • ⟨z, hzD⟩ := Subtype.ext rfl
        rw [hsm, map_smul, map_smul, ih hzD]
  refine LinearMap.ext ?_
  rintro ⟨x, hx⟩
  exact main x (hD ▸ hx) hx
