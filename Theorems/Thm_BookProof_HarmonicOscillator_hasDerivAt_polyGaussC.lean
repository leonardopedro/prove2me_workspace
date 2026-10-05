-- Generated from ChapterHarmonicOscillatorEsa.lean — theorem BookProof.HarmonicOscillator.hasDerivAt_polyGaussC
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.HarmonicOscillator



open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

theorem BookProof.HarmonicOscillator.hasDerivAt_polyGaussC (p : Polynomial ℝ) (x : ℝ) :
    HasDerivAt (polyGaussC p)
      ((((derivative p - C (1 / 2 : ℝ) * (X * p)).eval x * gaussH x : ℝ) : ℂ)) x := by sorry
