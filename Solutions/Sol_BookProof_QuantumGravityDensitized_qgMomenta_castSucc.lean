-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.qgMomenta_castSucc
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (xi : Fin n → ℝ) (xiY : ℝ) (a : Fin n) :
    qgMomenta xi xiY a.castSucc = xi a := by

  simp [qgMomenta]
