-- Generated from ChapterHarmonicOscillatorEsa.lean — theorem BookProof.HarmonicOscillator.deriv_deriv_hermiteC
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterA4
open BookProof.HermiteCore
open BookProof.HarmonicOscillator



open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

theorem BookProof.HarmonicOscillator.deriv_deriv_hermiteC (n : ℕ) (x : ℝ) :
    deriv (deriv (hermiteC n)) x
      = ((hermiteNorm n : ℝ) : ℂ)⁻¹ * ((deriv (deriv (hermiteFun n)) x : ℝ) : ℂ) := by sorry
