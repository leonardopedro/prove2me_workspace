-- Generated from ChapterHermiteGalerkinFriedrichs.lean — theorem BookProof.HermiteGalerkin.ritzSet_mono
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

theorem BookProof.HermiteGalerkin.ritzSet_mono (H : D →ₗ[ℂ] F) {V W : Submodule ℂ F} (hVW : V ≤ W) :
    ritzSet H V ⊆ ritzSet H W := by sorry
