-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.tendsto_densY_zero
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_continuous_densY
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution : Tendsto densY (𝓝[>] (0 : ℝ)) (𝓝 0) := (continuous_densY.tendsto' 0 0 Real.sqrt_zero).mono_left nhdsWithin_le_nhds
