-- Generated from ChapterSphericalBessel.lean — theorem BookProof.ChapterSphericalBessel.deriv_sbesselBase
import Mathlib
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel



open scoped Topology

theorem BookProof.ChapterSphericalBessel.deriv_sbesselBase {r : ℝ} (hr : r ≠ 0) :
    deriv sbesselBase r = Real.cos r / r - Real.sin r / r ^ 2 := by sorry
