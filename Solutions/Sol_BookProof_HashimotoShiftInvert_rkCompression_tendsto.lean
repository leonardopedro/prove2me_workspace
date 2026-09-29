-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.rkCompression_tendsto
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_rkProj_tendsto
import Theorems.Thm_BookProof_HermiteGalerkin_compression_tendsto_of_starProjection_tendsto
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (X : ℕ → F →L[ℂ] F) (v : F)
    (hdense : Dense ((⨆ m : ℕ, rkSpan X v m : Submodule ℂ F) : Set F)) (u : F) :
    Tendsto (fun m : ℕ => rkCompression T X v m u) atTop (nhds (T u)) := compression_tendsto_of_starProjection_tendsto _ T (rkProj_tendsto X v hdense) u
