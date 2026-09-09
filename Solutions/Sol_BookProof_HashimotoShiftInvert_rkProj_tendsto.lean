-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.rkProj_tendsto
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_rkSpan_mono
open BookProof.HashimotoShiftInvert



















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}




















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (X : ℕ → F →L[ℂ] F) (v : F)
    (hdense : Dense ((⨆ m : ℕ, rkSpan X v m : Submodule ℂ F) : Set F)) (u : F) :
    Tendsto (fun m : ℕ => (rkSpan X v m).starProjection u) atTop (nhds u) := starProjection_tendsto_of_monotone_dense _ (fun _ _ h => rkSpan_mono X v h) hdense u
