-- Generated from ChapterHarmonicOscillatorEsa.lean — theorem BookProof.HarmonicOscillator.hermiteC_oscillator
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterA4
open BookProof.HermiteCore



open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

theorem BookProof.HarmonicOscillator.hermiteC_oscillator (n : ℕ) (x : ℝ) :
    -(deriv (deriv (hermiteC n)) x) + ((x ^ 2 / 4 : ℝ) : ℂ) * hermiteC n x
      = (((n : ℝ) + 1 / 2 : ℝ) : ℂ) * hermiteC n x := by sorry
