-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.abs_linSymb_le
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
theorem solution (b : Fin d → ℝ) (x : Vd d) :
    |linSymb b x| ≤ (∑ i, |b i|) * ‖x‖ := by

  calc |linSymb b x| ≤ ∑ i, |b i * x i| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ i, |b i| * ‖x‖ := by
        refine Finset.sum_le_sum fun i _ => ?_
        rw [abs_mul]
        exact mul_le_mul_of_nonneg_left (coord_abs_le_norm x i) (abs_nonneg _)
    _ = (∑ i, |b i|) * ‖x‖ := by rw [Finset.sum_mul]
