-- Generated from ChapterHarmonicOscillatorEsa.lean — solution of BookProof.HarmonicOscillator.deriv_const_mul_fun
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
open BookProof.HarmonicOscillator




open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) {f : ℝ → ℂ} (hf : ∀ x, DifferentiableAt ℝ f x) :
    deriv (fun x => c * f x) = fun x => c * deriv f x := funext fun x => deriv_const_mul c (hf x)
