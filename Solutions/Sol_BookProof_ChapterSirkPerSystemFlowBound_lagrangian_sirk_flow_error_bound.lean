-- Generated from ChapterSirkPerSystemFlowBound.lean — solution of BookProof.ChapterSirkPerSystemFlowBound.lagrangian_sirk_flow_error_bound
import Mathlib
import Definitions.Def_ChapterSirkPerSystemFlowBound
import Theorems.Thm_BookProof_ChapterSirkPerSystemFlowBound_sirk_scheme_bound
import Theorems.Thm_BookProof_ChapterSirkPerSystem_lagrangian_sirk_crouzeix_domain
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
theorem solution {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [CompleteSpace F] (L : LagrangianFullData F)
    (hesa : EssentiallySelfAdjointOn L.D (lagrangianCore L)) {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (X : F →L[ℂ] F),
      IsSelfAdjointExtension (lagrangianCore L) A ∧ IsShiftInvertC A γ X ∧
      ‖X‖ ≤ |γ.im|⁻¹ ∧ numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] F)
        (s : RationalScheme F (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
        IsSirkScheme X V (Metric.closedBall (0 : ℂ) |γ.im|⁻¹) C Dmin h m s →
        ∀ (flow : F →L[ℂ] F), flow = s.psiX →
        ∀ v : F, V (V.adjoint v) = v →
          ‖flow v - sirkApprox V s.psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by

  obtain ⟨Dom, A, X, hext, hX, hnorm, hball, -⟩ := lagrangian_sirk_crouzeix_domain L hesa hγ
  exact ⟨Dom, A, X, hext, hX, hnorm, hball,
    fun _ _ _ _ _ _ hs flow hflow v hv => sirk_scheme_bound hs hball flow hflow v hv⟩
