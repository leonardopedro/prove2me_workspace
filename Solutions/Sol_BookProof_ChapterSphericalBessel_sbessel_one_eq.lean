-- Generated from ChapterSphericalBessel.lean — solution of BookProof.ChapterSphericalBessel.sbessel_one_eq
import Mathlib
import Definitions.Def_ChapterSphericalBessel
import Theorems.Thm_BookProof_ChapterSphericalBessel_deriv_sbesselBase
open BookProof.ChapterSphericalBessel




open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution {r : ℝ} (hr : r ≠ 0) : sbessel 1 r = sj1 r := by

  have hd := deriv_sbesselBase hr
  simp only [sbessel, sj1, rayleighOp, Function.iterate_one, pow_one, hd]
  field_simp; ring
