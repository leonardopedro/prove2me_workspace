-- Generated from ChapterHarmonicOscillatorEsa.lean — solution of BookProof.HarmonicOscillator.hermiteC_eq
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
open BookProof.HarmonicOscillator




open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    hermiteC n = fun x => ((hermiteNorm n : ℝ) : ℂ)⁻¹ * polyGaussC (hermiteR n) x := by

  funext x
  simp only [hermiteC, hermiteFun, polyGaussC]
  push_cast
  ring
