-- Generated from ChapterHarmonicOscillatorEsa.lean — solution of BookProof.HarmonicOscillator.harmonicOscOp_apply_eq_differential
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Theorems.Thm_BookProof_HarmonicOscillator_hermiteC_oscillator
import Theorems.Thm_BookProof_HarmonicOscillator_harmonicOscOp_hermiteLp
import Theorems.Thm_BookProof_HarmonicOscillator_memLp_harmonicDifferential
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteLp_mem_hermiteCore
open BookProof.HarmonicOscillator




open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    harmonicOscOp ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
      = (memLp_harmonicDifferential n).toLp _ := by

  rw [harmonicOscOp_hermiteLp]
  refine MeasureTheory.Lp.ext ?_
  filter_upwards [(memLp_harmonicDifferential n).coeFn_toLp, hermiteLp_coeFn n,
    Lp.coeFn_smul ((harmonicSymbol n : ℂ)) (hermiteLp n)] with x h1 h2 h3
  rw [h1, h3]
  simp only [Pi.smul_apply, smul_eq_mul, h2, hermiteC_oscillator n x, harmonicSymbol]
