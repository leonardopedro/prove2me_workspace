-- Generated from ChapterHarmonicOscillatorEsa.lean — solution of BookProof.HarmonicOscillator.deriv_polyGaussC
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Theorems.Thm_BookProof_HarmonicOscillator_hasDerivAt_polyGaussC
open BookProof.HarmonicOscillator




open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) :
    deriv (polyGaussC p) = polyGaussC (derivative p - C (1 / 2 : ℝ) * (X * p)) := funext fun x => (hasDerivAt_polyGaussC p x).deriv
