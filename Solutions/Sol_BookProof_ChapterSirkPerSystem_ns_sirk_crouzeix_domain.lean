-- Generated from ChapterSirkPerSystem.lean — solution of BookProof.ChapterSirkPerSystem.ns_sirk_crouzeix_domain
import Mathlib
import Definitions.Def_ChapterSirkPerSystem
open BookProof.ChapterSirkPerSystem










noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH9 BookProof.ChapterSirkSpectralGeometry
open BookProof.HashimotoShiftInvert BookProof.FarisLavine BookProof.EsaClosure
open BookProof.YangMillsFriedrichs BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.Starobinsky
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.NSHashimoto
open BookProof.NavierStokesFlow.DiffHashimoto BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.LagrangianEsa BookProof.NavierStokesFlow.LagrangianKatoRellich

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)
    (b : HilbertBasis ℕ ℂ (L2I Vel)) (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel)
      (X : ℕ → L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G ∧
      (∀ j, IsShiftInvertC G (γ j) (X j)) ∧
      (∀ j, numRange (X j) ⊆ Metric.closedBall (0 : ℂ) |(γ j).im|⁻¹) ∧
      ∀ (j m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2I Vel), (∀ x, ‖V x‖ = ‖x‖) →
        convexHull ℝ (numRange (compress V (X j)))
          ⊆ Metric.closedBall (0 : ℂ) |(γ j).im|⁻¹ := by

  obtain ⟨Dom, G, X, hext, hX, -, -, -, -, -, -, -, -⟩ := ns_hashimoto_selects A c b γ hγ
  have hsym := hext.2.1
  exact ⟨Dom, G, X, hext, hX,
    fun j => numRange_subset_closedBall_of_shiftInvertC (hX j) hsym (hγ j),
    fun j _ V hViso => crouzeix_domain_shiftInvertC (hX j) hsym (hγ j) V hViso⟩
