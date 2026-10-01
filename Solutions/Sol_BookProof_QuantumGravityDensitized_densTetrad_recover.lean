-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.densTetrad_recover
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution {E : Matrix (Fin 3) (Fin 3) ℝ} (h : 0 < E.det) :
    (Real.sqrt E.det)⁻¹ • densTetrad E = E := by

  rw [densTetrad, smul_smul, inv_mul_cancel₀ (ne_of_gt (Real.sqrt_pos.mpr h)), one_smul]
