-- Generated from ChapterSphericalBessel.lean — solution of BookProof.ChapterSphericalBessel.rayleigh_raise_01
import Mathlib
import Definitions.Def_ChapterSphericalBessel
import Theorems.Thm_BookProof_ChapterSphericalBessel_deriv_sbesselBase
open BookProof.ChapterSphericalBessel




open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution {r : ℝ} (hr : r ≠ 0) : sj1 r = -deriv sj0 r := by

  have hd : deriv sj0 r = Real.cos r / r - Real.sin r / r ^ 2 := deriv_sbesselBase hr
  rw [hd, sj1]; ring
