-- Generated from ChapterSirkPerSystemFlowBound.lean — solution of BookProof.ChapterSirkPerSystemFlowBound.nsDiff_sirk_flow_error_bound
import Mathlib
import Definitions.Def_ChapterSirkPerSystemFlowBound
import Theorems.Thm_BookProof_ChapterSirkPerSystemFlowBound_sirk_scheme_bound
import Theorems.Thm_BookProof_ChapterSirkPerSystem_nsDiff_sirk_crouzeix_domain
open BookProof.ChapterSirkPerSystemFlowBound



noncomputable section

open Filter Topology


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.ChapterSirkSpectralGeometry
open BookProof.ChapterSirkPerSystem
open BookProof.HashimotoShiftInvert BookProof.FarisLavine BookProof.EsaClosure
open BookProof.YangMillsFriedrichs BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.Starobinsky
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.NSHashimoto
open BookProof.NavierStokesFlow.DiffHashimoto BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.LagrangianEsa BookProof.NavierStokesFlow.LagrangianKatoRellich

variable {E G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

variable {E G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2d 3)) (G : Dom →ₗ[ℂ] L2d 3) (X : L2d 3 →L[ℂ] L2d 3),
      IsSelfAdjointExtension ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) G ∧
      IsShiftInvertC G γ X ∧ ‖X‖ ≤ |γ.im|⁻¹ ∧
      numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2d 3)
        (s : RationalScheme (L2d 3) (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
        IsSirkScheme X V (Metric.closedBall (0 : ℂ) |γ.im|⁻¹) C Dmin h m s →
        ∀ (flow : L2d 3 →L[ℂ] L2d 3), flow = s.psiX →
        ∀ v : L2d 3, V (V.adjoint v) = v →
          ‖flow v - sirkApprox V s.psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by

  obtain ⟨Dom, Gop, X, hext, hX, hnorm, hball, -⟩ := nsDiff_sirk_crouzeix_domain A c hγ
  exact ⟨Dom, Gop, X, hext, hX, hnorm, hball,
    fun _ _ _ _ _ _ hs flow hflow v hv => sirk_scheme_bound hs hball flow hflow v hv⟩
