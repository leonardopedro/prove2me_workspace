-- Generated from ChapterHarmonicOscillatorEsa.lean — theorem BookProof.HarmonicOscillator.hermiteC_oscillator
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.HarmonicOscillator



open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

theorem BookProof.HarmonicOscillator.hermiteC_oscillator (n : ℕ) (x : ℝ) :
    -(deriv (deriv (hermiteC n)) x) + ((x ^ 2 / 4 : ℝ) : ℂ) * hermiteC n x
      = (((n : ℝ) + 1 / 2 : ℝ) : ℂ) * hermiteC n x := by sorry
