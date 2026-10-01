-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.tendsto_inv_det_atTop
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution : Tendsto (fun e : ℝ => 1 / e) (𝓝[>] (0 : ℝ)) atTop := by

  simpa using tendsto_inv_nhdsGT_zero
