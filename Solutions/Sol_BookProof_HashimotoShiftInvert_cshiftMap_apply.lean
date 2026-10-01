-- Generated from ChapterComplexShiftCore.lean — solution of BookProof.HashimotoShiftInvert.cshiftMap_apply
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (A : Dom →ₗ[ℂ] F) (γ : ℂ) (x : Dom) :
    cshiftMap A γ x = γ • (x : F) - A x := rfl
