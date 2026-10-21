-- Generated from ChapterSirkPerSystemFlowBound.lean — solution of BookProof.ChapterSirkPerSystemFlowBound.qgR2_sirk_flow_error_tendsto_zero
import Mathlib
import Definitions.Def_ChapterSirkPerSystemFlowBound
import Theorems.Thm_BookProof_ChapterSirkPerSystemFlowBound_sirk_scheme_tendsto
import Theorems.Thm_BookProof_ChapterSirkPerSystem_qgR2_sirk_crouzeix_domain
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
theorem solution (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ L2Nat) (A : Dom →ₗ[ℂ] L2Nat) (X : L2Nat →L[ℂ] L2Nat),
      IsSelfAdjointExtension (qgR2ModeHamiltonian a b M alpha Rc) A ∧
      IsShiftInvertC A γ X ∧ numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (V : ∀ m : ℕ, EuclideanSpace ℂ (Fin m) →L[ℂ] L2Nat)
        (s : ∀ m : ℕ, RationalScheme L2Nat (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
        0 < h →
        (∀ m, IsSirkScheme X (V m) (Metric.closedBall (0 : ℂ) |γ.im|⁻¹) C Dmin h m (s m)) →
        ∀ (flow : L2Nat →L[ℂ] L2Nat), (∀ m, flow = (s m).psiX) →
        ∀ v : L2Nat, (∀ m, V m ((V m).adjoint v) = v) →
          Tendsto (fun m => ‖flow v - sirkApprox (V m) (s m).psiB v‖) atTop (𝓝 0) := by

  obtain ⟨Dom, A, X, hext, hX, -, hball, -⟩ := qgR2_sirk_crouzeix_domain a b M alpha Rc hγ
  exact ⟨Dom, A, X, hext, hX, hball,
    fun V s _ _ _ hh hs flow hflow v hv => sirk_scheme_tendsto hh hball V s hs flow hflow v hv⟩
