-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.densTetrad_det
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (E : Matrix (Fin 3) (Fin 3) ℝ) :
    (densTetrad E).det = Real.sqrt E.det ^ 3 * E.det := by

  simp [densTetrad]
