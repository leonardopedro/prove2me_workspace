-- Generated from ChapterHarmonicOscillatorEsa.lean — theorem BookProof.HarmonicOscillator.hermiteC_eq
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.HarmonicOscillator



open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

theorem BookProof.HarmonicOscillator.hermiteC_eq (n : ℕ) :
    hermiteC n = fun x => ((hermiteNorm n : ℝ) : ℂ)⁻¹ * polyGaussC (hermiteR n) x := by sorry
