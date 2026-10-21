-- Generated from ChapterSirkPerSystemFlowBound.lean — solution of BookProof.ChapterSirkPerSystemFlowBound.isSirkScheme_trivial
import Mathlib
import Definitions.Def_ChapterSirkPerSystemFlowBound
import Theorems.Thm_BookProof_ChapterSirkPerSystemFlowBound_adjoint_comp_self_of_isometry
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
theorem solution (X : E →L[ℂ] E) (V : G →L[ℂ] E)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖) (hinvX : ∀ x : G, ∃ y : G, X (V x) = V y)
    (S : Set ℂ) (h : ℝ) (m : ℕ) :
    IsSirkScheme X V S 1 1 h m
      { qX := by

  have hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ G :=
    adjoint_comp_self_of_isometry V hViso
  have hcid : compress V (ContinuousLinearMap.id ℂ E) = ContinuousLinearMap.id ℂ G := by
    rw [compress, ContinuousLinearMap.id_comp, hVV]
  refine ⟨hViso, hinvX, fun x => ⟨x, rfl⟩, by ext x; simp, ?_, ?_, ?_⟩
  · rw [hcid]; ext x; simp
  · intro _
    have hXid : (Polynomial.aeval X (Polynomial.X : Polynomial ℂ) : E →L[ℂ] E).comp
        (ContinuousLinearMap.id ℂ E) = X := by ext x; simp
    rw [hXid, sub_self, norm_zero]
    positivity
  · intro _
    have hBid : (Polynomial.aeval (compress V X) (Polynomial.X : Polynomial ℂ) : G →L[ℂ] G).comp
        (ContinuousLinearMap.id ℂ G) = compress V X := by ext x; simp
    rw [hBid, sub_self, norm_zero]
    positivity
