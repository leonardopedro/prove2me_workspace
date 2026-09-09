-- Generated from ChapterNavierStokesHashimoto.lean — theorem
-- BookProof.NavierStokesFlow.NSHashimoto.ns_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterNavierStokesHashimoto
import Definitions.Def_ChapterHashimotoComplexShifts
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.NavierStokesFlow.NSHashimoto
open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.IkebeKato
open BookProof.HermiteGalerkin
open Filter Topology

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem BookProof.NavierStokesFlow.NSHashimoto.ns_hashimoto_selects (b : HilbertBasis ℕ ℂ (L2I Vel))
    (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel) (X : ℕ → L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G ∧
      (∀ j, IsShiftInvertC G (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : L2I Vel →ₗ[ℂ] L2I Vel))) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ (L2I Vel) - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) b n u) atTop (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ (L2I Vel)) (A' : Dom' →ₗ[ℂ] L2I Vel),
        IsShiftInvertC A' (γ j) (X j) →
          Dom' = Dom ∧ ∀ (x : L2I Vel) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
            A' ⟨x, hx'⟩ = G ⟨x, hx⟩) := by sorry