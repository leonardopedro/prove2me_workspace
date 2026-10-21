-- Generated from ChapterHarmonicOscillatorEsa.lean — solution of BookProof.HarmonicOscillator.hasDerivAt_polyGaussC
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Theorems.Thm_BookProof_HermiteCore_hasDerivAt_poly_mul_gaussH
open BookProof.HarmonicOscillator




open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) (x : ℝ) :
    HasDerivAt (polyGaussC p)
      ((((derivative p - C (1 / 2 : ℝ) * (X * p)).eval x * gaussH x : ℝ) : ℂ)) x := (hasDerivAt_poly_mul_gaussH p x).ofReal_comp
