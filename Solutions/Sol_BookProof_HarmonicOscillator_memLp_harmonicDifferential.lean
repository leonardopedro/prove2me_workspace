-- Generated from ChapterHarmonicOscillatorEsa.lean — solution of BookProof.HarmonicOscillator.memLp_harmonicDifferential
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Theorems.Thm_BookProof_HarmonicOscillator_hermiteC_oscillator
open BookProof.HarmonicOscillator




open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    MemLp (fun x : ℝ => -(deriv (deriv (hermiteC n)) x) + ((x ^ 2 / 4 : ℝ) : ℂ) * hermiteC n x)
      2 (volume : Measure ℝ) := by

  have h : (fun x : ℝ => -(deriv (deriv (hermiteC n)) x) + ((x ^ 2 / 4 : ℝ) : ℂ) * hermiteC n x)
      = fun x : ℝ => (((n : ℝ) + 1 / 2 : ℝ) : ℂ) * hermiteC n x := by
    funext x
    exact hermiteC_oscillator n x
  rw [h]
  exact (memLp_hermiteC n).const_mul _
