-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.foMod_mul_foPhase
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b b' : Fin d → ℝ) (i : Fin d) :
    ((foMod b b' i : ℝ) : ℂ) * foPhase b b' i = foAmp b b' i := by

  rw [foPhase]
  split_ifs with h
  · rw [h, mul_one]
    simp [foMod, h]
  · have hne : ((foMod b b' i : ℝ) : ℂ) ≠ 0 := by
      simpa [foMod, Complex.ofReal_eq_zero] using h
    field_simp
