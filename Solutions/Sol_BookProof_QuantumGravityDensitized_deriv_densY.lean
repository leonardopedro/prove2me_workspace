-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.deriv_densY
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_hasDerivAt_densY
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution {e : ℝ} (he : e ≠ 0) : deriv densY e = 1 / (2 * Real.sqrt e) := (hasDerivAt_densY he).deriv
