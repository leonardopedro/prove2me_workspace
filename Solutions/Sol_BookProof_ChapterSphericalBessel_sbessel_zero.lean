-- Generated from ChapterSphericalBessel.lean — solution of BookProof.ChapterSphericalBessel.sbessel_zero
import Mathlib
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel




open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution : sbessel 0 = sj0 := by

  funext r; simp [sbessel, sbesselBase, sj0]
