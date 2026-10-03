-- Generated from ChapterHarmonicOscillatorEsa.lean — theorem BookProof.HarmonicOscillator.deriv_polyGaussC
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterA4
open BookProof.HermiteCore



open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

theorem BookProof.HarmonicOscillator.deriv_polyGaussC (p : Polynomial ℝ) :
    deriv (polyGaussC p) = polyGaussC (derivative p - C (1 / 2 : ℝ) * (X * p)) := by sorry
