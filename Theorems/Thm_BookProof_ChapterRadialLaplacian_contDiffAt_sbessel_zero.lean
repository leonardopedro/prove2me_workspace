-- Generated from ChapterRadialLaplacian.lean — theorem BookProof.ChapterRadialLaplacian.contDiffAt_sbessel_zero
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterSphericalBessel
import Definitions.Def_ChapterSphericalBesselODE
open BookProof.ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE
open BookProof.ChapterRadialLaplacian

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace


theorem BookProof.ChapterRadialLaplacian.contDiffAt_sbessel_zero {r : ℝ} (hr : r ≠ 0) : ContDiffAt ℝ 2 (sbessel 0) r := by sorry
