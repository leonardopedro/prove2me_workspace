-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.hasDerivAt_densY
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution {e : ℝ} (he : e ≠ 0) :
    HasDerivAt densY (1 / (2 * Real.sqrt e)) e := Real.hasDerivAt_sqrt he
