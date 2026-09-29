-- Generated from ChapterHermiteGalerkinFriedrichs.lean — theorem BookProof.HermiteGalerkin.positive_selfadjoint_extension_unique
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

theorem BookProof.HermiteGalerkin.positive_selfadjoint_extension_unique {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (A : F →L[ℂ] F) (hAH : ∀ x : D, A (x : F) = H x)
    (B : (⊤ : Submodule ℂ F) →ₗ[ℂ] F) (hB : IsPositiveSelfAdjointExtension H B) (x : F) :
    B ⟨x, trivial⟩ = A x := by sorry
