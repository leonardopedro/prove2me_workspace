-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.norm_foPhase
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
theorem solution (b b' : Fin d → ℝ) (i : Fin d) : ‖foPhase b b' i‖ = 1 := by

  rw [foPhase]
  split_ifs with h
  · simp
  · rw [norm_div, Complex.norm_real, Real.norm_eq_abs, foMod, abs_norm,
      div_self (norm_ne_zero_iff.mpr h)]
