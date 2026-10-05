-- Generated from ChapterHarmonicOscillatorEsa.lean — theorem BookProof.HarmonicOscillator.deriv_const_mul_fun
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
open BookProof.HarmonicOscillator



open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

theorem BookProof.HarmonicOscillator.deriv_const_mul_fun (c : ℂ) {f : ℝ → ℂ} (hf : ∀ x, DifferentiableAt ℝ f x) :
    deriv (fun x => c * f x) = fun x => c * deriv f x := by sorry
