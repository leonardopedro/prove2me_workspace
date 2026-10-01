-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.qgMetric_det
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    (qgMetric n).det = ∏ i, (if i = Fin.last n then -(1 / 24) else 1 / 16 : ℝ) := Matrix.det_diagonal
