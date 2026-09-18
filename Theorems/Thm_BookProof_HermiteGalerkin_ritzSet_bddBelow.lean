-- Generated from ChapterHermiteGalerkinFriedrichs.lean — theorem BookProof.HermiteGalerkin.ritzSet_bddBelow
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

theorem BookProof.HermiteGalerkin.ritzSet_bddBelow (H : D →ₗ[ℂ] F) (hpos : ∀ x : D, 0 ≤ quadForm H x)
    (V : Submodule ℂ F) : BddBelow (ritzSet H V) := by sorry
