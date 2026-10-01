-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.qgMomenta_last
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ) :
    qgMomenta xi xiY (Fin.last n) = xiY := by

  simp [qgMomenta]
