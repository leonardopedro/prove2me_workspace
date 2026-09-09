-- Generated from ChapterNavierStokesDiffHashimoto.lean — solution of BookProof.NavierStokesFlow.DiffHashimoto.nsQuadraticDiffH_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffHashimoto
import Theorems.Thm_BookProof_NavierStokesFlow_DiffHashimoto_nsDiffH_hashimoto_selects
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffHashimoto








open Filter Topology



open MvPolynomial
open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (grad : Matrix (Fin 3) (Fin 3) ℝ)
    (lap : Fin 3 → ℝ) (b : HilbertBasis ℕ ℂ (L2d 3)) (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2d 3)) (G : Dom →ₗ[ℂ] L2d 3) (X : ℕ → L2d 3 →L[ℂ] L2d 3),
      IsSelfAdjointExtension
        ((polyGaussCore (d := 3)).subtype.comp (nsQuadraticDiffH nu grad lap)) G ∧
      (∀ j, IsShiftInvertC G (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : L2d 3 →ₗ[ℂ] L2d 3))) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) b n u) atTop (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ (L2d 3)) (G' : Dom' →ₗ[ℂ] L2d 3),
        IsShiftInvertC G' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : L2d 3) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          G' ⟨x, hx'⟩ = G ⟨x, hx⟩) := by

  obtain ⟨Dom, G, X, hext, hsi, hnorm, hdom, _, _, _, _, hgal, hdet⟩ :=
    nsDiffH_hashimoto_selects grad (fun i => -(nu * lap i)) b γ hγ
  exact ⟨Dom, G, X, hext, hsi, hnorm, hdom, hgal, hdet⟩
