-- Generated from ChapterSchrodingerCutoffEsa.lean — theorem BookProof.SchrodingerCutoff.hasDerivAt_reInner
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
open BookProof.SchrodingerCutoff



open MeasureTheory Filter Complex

theorem BookProof.SchrodingerCutoff.hasDerivAt_reInner (u u' u'' : ℝ → ℂ) (x : ℝ)
    (h1 : HasDerivAt u (u' x) x) (h2 : HasDerivAt u' (u'' x) x) :
    HasDerivAt (fun y => ((starRingEnd ℂ) (u y) * u' y).re)
      (‖u' x‖ ^ 2 + ((starRingEnd ℂ) (u x) * u'' x).re) x := by sorry
