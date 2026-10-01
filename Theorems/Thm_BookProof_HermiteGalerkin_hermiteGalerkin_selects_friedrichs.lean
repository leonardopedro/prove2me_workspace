-- Generated from ChapterHermiteGalerkinFriedrichs.lean — theorem BookProof.HermiteGalerkin.hermiteGalerkin_selects_friedrichs
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichsLimit
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

theorem BookProof.HermiteGalerkin.hermiteGalerkin_selects_friedrichs (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn (finiteModeDomain b) H)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x)
    (C : ℝ) (hbd : ∀ x : finiteModeDomain b, ‖H x‖ ≤ C * ‖(x : F)‖) :
    ∃ A : F →L[ℂ] F,
      (∀ x : finiteModeDomain b, A (x : F) = H x) ∧
      IsPositiveSelfAdjointExtension H (topRestrict A) ∧
      (∀ (B : (⊤ : Submodule ℂ F) →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H B →
        ∀ x : F, B ⟨x, trivial⟩ = A x) ∧
      (∀ u : F, Tendsto (fun m : ℕ => galerkinCompression A b m u) atTop (nhds (A u))) ∧
      (∀ (z : ℂ), z.im ≠ 0 → ∀ u : F,
        Tendsto (fun m : ℕ => resolvent (galerkinCompression A b m) z u) atTop
          (nhds (resolvent A z u))) := by sorry
