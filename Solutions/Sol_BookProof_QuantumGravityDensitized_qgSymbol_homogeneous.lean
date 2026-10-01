-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.qgSymbol_homogeneous
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (c : ℝ) (xi : Fin n → ℝ) (xiY : ℝ) :
    qgSymbol (fun a => c * xi a) (c * xiY) = c ^ 2 * qgSymbol xi xiY := by

  simp only [qgSymbol, mul_pow, ← Finset.mul_sum]
  ring
