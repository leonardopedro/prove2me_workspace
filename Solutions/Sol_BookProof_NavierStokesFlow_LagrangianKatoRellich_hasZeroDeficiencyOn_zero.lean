-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.hasZeroDeficiencyOn_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
 A' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : L2N) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  lagrangian_hashimoto_selects diagKR diagKR_hFull_essentiallySelfAdjoi :=
  ntOn l2NatBasis γ hγ
  
  end Instance
  
  /-! ## The sharpness record, seen from here -/
  
  section Sharpness
  
  open LpNat JacobiDeficiency
  
  variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  
  /-- The zero operator on a dense domain is essentially self-adjoint. -/
  theorem hasZeroDeficiencyOn_zero {D : Submodule ℂ F} (hd : Dense (D : Set F)) :
      HasZeroDeficiencyOn D (0 : D →ₗ[ℂ] D) := by
    have key : ∀ w : F, (∀ v : D, (inner ℂ (v : F) w : ℂ) = 0) → w = 0 := by
      intro w hw
      have hclosed : IsClosed {y : F | (inner ℂ y w : ℂ) = 0} :=
        isClosed_eq (Continuous.inner continuous_id continuous_const) continuous_const
      have hsub : (D : Set F) ⊆ {y : F | (inner ℂ y w : ℂ) = 0} := fun y hy => hw ⟨y, hy⟩
      have huniv := hclosed.closure_subset_iff.mpr hsub
      rw [hd.closure_eq] at huniv
      exact inner_self_eq_zero.mp (huniv (Set.mem_univ w))
    constructor <;> intro w hw <;> refine key w fun v => ?_
