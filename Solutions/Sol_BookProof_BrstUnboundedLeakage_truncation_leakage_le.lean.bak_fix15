-- Generated from ChapterBrstUnboundedLeakage.lean — solution of BookProof.BrstUnboundedLeakage.truncation_leakage_le
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Theorems.Thm_BookProof_BrstUnboundedLeakage_leakage_le
import Theorems.Thm_BookProof_BrstUnboundedLeakage_flow_truncGen_mem_domain
import Theorems.Thm_BookProof_BrstUnboundedLeakage_defect_orbit_le
open BookProof.BrstUnboundedLeakage



open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable (V : Submodule ℂ H) [FiniteDimensional ℂ V] (hV : V ≤ T.domain)

set_option maxHeartbeats 1000000 in
theorem solution {Om : H →L[ℂ] H}
    (hcomm : ∀ (s : ℝ) (y : H), Om (T.stoneU s y) = T.stoneU s (Om y))
    (t : ℝ) (ht : 0 ≤ t) {x : H} (hx : x ∈ V) :
    ‖Om (flow (truncGen T V hV) t x)‖
      ≤ ‖Om x‖ + ‖Om‖ * (‖truncDefect T V hV‖ * ‖x‖ * t) := by

  have h := leakage_le T (B := truncGen T V hV) hcomm t ht x
    (fun s => flow_truncGen_mem_domain T V hV s hx) (‖truncDefect T V hV‖ * ‖x‖)
    (fun s _ => defect_orbit_le T V hV hx s)
  simpa [mul_assoc] using h
