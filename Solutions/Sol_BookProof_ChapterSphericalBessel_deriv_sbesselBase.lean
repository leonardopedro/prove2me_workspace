-- Generated from ChapterSphericalBessel.lean — solution of BookProof.ChapterSphericalBessel.deriv_sbesselBase
import Mathlib
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel




open scoped Topology

set_option maxHeartbeats 1000000 in
theorem solution {r : ℝ} (hr : r ≠ 0) :
    deriv sbesselBase r = Real.cos r / r - Real.sin r / r ^ 2 := by

  have hd : HasDerivAt (fun x => Real.sin x / x)
      ((Real.cos r * id r - Real.sin r * 1) / id r ^ 2) r :=
    HasDerivAt.div (Real.hasDerivAt_sin r) (hasDerivAt_id r) hr
  have heq : (Real.cos r * id r - Real.sin r * 1) / id r ^ 2
      = Real.cos r / r - Real.sin r / r ^ 2 := by
    simp only [id_eq, mul_one]
    field_simp [hr]
  rw [show sbesselBase = fun x => Real.sin x / x from rfl]
  rw [HasDerivAt.deriv hd, heq]
