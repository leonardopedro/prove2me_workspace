-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.conformal_absorption
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_densY_pos
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (e p : ℝ) (he : 0 < e) :
    1 / (24 * e) * p ^ 2 = 1 / 24 * (p / densY e) ^ 2 := by

  have hs : densY e ^ 2 = e := Real.sq_sqrt he.le
  have hpos : 0 < densY e := densY_pos he
  field_simp
  nlinarith [hs]
