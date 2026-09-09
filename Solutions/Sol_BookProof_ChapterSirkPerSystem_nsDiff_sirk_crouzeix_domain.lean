-- Generated from ChapterSirkPerSystem.lean — solution of BookProof.ChapterSirkPerSystem.nsDiff_sirk_crouzeix_domain
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
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2d 3)) (G : Dom →ₗ[ℂ] L2d 3) (X : L2d 3 →L[ℂ] L2d 3),
      IsSelfAdjointExtension ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) G ∧
      IsShiftInvertC G γ X ∧ ‖X‖ ≤ |γ.im|⁻¹ ∧
      numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2d 3), (∀ x, ‖V x‖ = ‖x‖) →
        convexHull ℝ (numRange (compress V X)) ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ := by

  obtain ⟨Dom, G, X, hext, hX, hnorm, -, -⟩ := nsDiffH_shiftInvert_selects A c hγ
  have hsym := hext.2.1
  exact ⟨Dom, G, X, hext, hX, hnorm,
    numRange_subset_closedBall_of_shiftInvertC hX hsym hγ,
    fun _ V hViso => crouzeix_domain_shiftInvertC hX hsym hγ V hViso⟩
