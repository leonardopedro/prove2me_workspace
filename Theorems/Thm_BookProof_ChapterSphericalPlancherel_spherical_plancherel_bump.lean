-- Generated from ChapterSphericalPlancherel.lean — theorem BookProof.ChapterSphericalPlancherel.spherical_plancherel_bump
import Definitions.Def_ChapterSphericalBessel
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel



open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalPlancherel.spherical_plancherel_bump :
    ∫ p in Ioi (0 : ℝ), ‖sphericalTransform (fun r : ℝ => oddBump r / (r : ℂ)) p‖ ^ 2 * p ^ 2
      = ∫ r in Ioi (0 : ℝ), ‖oddBump r / (r : ℂ)‖ ^ 2 * r ^ 2 := by sorry
