-- Generated from ChapterHermiteGalerkinFriedrichs.lean — theorem BookProof.HermiteGalerkin.finiteModeRestrict_apply
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

theorem BookProof.HermiteGalerkin.finiteModeRestrict_apply (A₀ : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    (x : finiteModeDomain b) : finiteModeRestrict A₀ b x = A₀ (x : F) := by sorry
