-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.kinetic_absorption
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_densY_pos
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (e s : ℝ) (he : 0 < e) :
    1 / (16 * e) * s ^ 2 = 1 / 16 * (s / densY e) ^ 2 := by

  have hs : densY e ^ 2 = e := Real.sq_sqrt he.le
  have hpos : 0 < densY e := densY_pos he
  field_simp
  nlinarith [hs]
